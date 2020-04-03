//
//  Map.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 30/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Foundation

// MARK: Flow Model

final class FlowMapModels {
    fileprivate var modelMap = MapModel()
}

// MARK: Flow

final class FlowMap: BaseFlow {
    fileprivate var models = FlowMapModels()
    override func start() {
        moduleMap(.replace)
    }
}

// MARK: Modules

extension FlowMap {
    
    // MARK: Root Module - Map
    
    fileprivate func moduleMap(_ transition: Router.Transition) {
        let module = MapView()
        module.viewModel.initialize(models.modelMap) { module.reload() }
//        module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelMap = module.viewModel.model
            switch MapViewModel.EventType(rawValue: event) {
            case .onFinish?: self.finish()
            case .none: self.eventError(event)
            case .some(.onAccurancy): coordinator.runFlowAccurancy()
            case .some(.onFavorite): router.transition(.present, coordinator.stack.0[2].navigation)
            }
        }
        setRootController(module)
        setNavigationController()
        navigation.isNavigationBarHidden = true
        coordinator.setSideMenuButton(module)
        router.transition(transition, navigation)
    }
    
}
