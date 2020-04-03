//
//  WishList.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 03/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Foundation

// MARK: Flow Model

final class FlowWishListModels {
    fileprivate var modelWishList = WishListModel()
}

// MARK: Flow

final class FlowWishList: BaseFlow {
    fileprivate var models = FlowWishListModels()
    override func start() {
        moduleWishList(.present)
    }
}

// MARK: Modules

extension FlowWishList {
    
    // MARK: Root Module - WishList
    
    fileprivate func moduleWishList(_ transition: Router.Transition) {
        let module = WishListView()
        module.viewModel.initialize(models.modelWishList) { module.reload() }
//        module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelWishList = module.viewModel.model
            switch WishListViewModel.EventType(rawValue: event) {
            case .onFinish?: self.finish()
            case .none: self.eventError(event)
            }
        }
        module.setDismissButton()
        setRootController(module)
        setNavigationController()
//        coordinator.setSideMenuButton(module)
        router.transition(transition, navigation)
    }
    
}
