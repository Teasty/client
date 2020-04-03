//
//  Favorite.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 01/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Foundation

// MARK: Flow Model

final class FlowFavoriteModels {
    fileprivate var modelFavorite = FavoriteModel()
    fileprivate var modelNewAddress = NewAddressModel()
}

// MARK: Flow

final class FlowFavorite: BaseFlow {
    fileprivate var models = FlowFavoriteModels()
    override func start() {
        moduleFavorite(.replace)
    }
}

// MARK: Modules

extension FlowFavorite {
    
    // MARK: Root Module - Favorite
    
    fileprivate func moduleFavorite(_ transition: Router.Transition) {
        let module = FavoriteView()
        module.viewModel.initialize(models.modelFavorite) { module.reload() }
//        module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelFavorite = module.viewModel.model
            switch FavoriteViewModel.EventType(rawValue: event) {
            case .onFinish?: self.finish()
            case .none: self.eventError(event)
            case .some(.addNewAddress): self.moduleNewAddress(.push)
            case .some(.onSelect): module.dismiss(animated: true, completion: nil)
            }
        }
        module.setDismissButton()
        setRootController(module)
        setNavigationController()
        //        coordinator.setSideMenuButton(navigation)
        //        router.transition(transition, navigation)
    }
    
    // MARK: NewAddress
    
    fileprivate func moduleNewAddress(_ transition: Router.Transition) {
        let module = NewAddressView()
        module.viewModel.initialize(models.modelNewAddress) { module.reload() }
        // module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelNewAddress = module.viewModel.model
            switch NewAddressViewModel.EventType(rawValue: event) {
            case .onFinish?: break
            case .none: self.eventError(event)
            case .some(.onAddressAdd): break
            }
        }
        router.transition(transition, module)
    }
}
