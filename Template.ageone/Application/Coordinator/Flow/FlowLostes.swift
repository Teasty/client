//
//  Lostes.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 01/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Foundation

// MARK: Flow Model

final class FlowLostesModels {
    fileprivate var modelLostes = LostesModel()
}

// MARK: Flow

final class FlowLostes: BaseFlow {
    fileprivate var models = FlowLostesModels()
    override func start() {
        moduleLostes(.replace)
    }
}

// MARK: Modules

extension FlowLostes {
    
    // MARK: Root Module - Lostes
    
    fileprivate func moduleLostes(_ transition: Router.Transition) {
        let module = LostesView()
        module.viewModel.initialize(models.modelLostes) { module.reload() }
//        module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelLostes = module.viewModel.model
            switch LostesViewModel.EventType(rawValue: event) {
            case .onFinish?: self.finish()
            case .none: self.eventError(event)
            }
        }
        module.setDismissButton()
        setRootController(module)
        setNavigationController()
        //        coordinator.setSideMenuButton(navigation)
        //        router.transition(transition, navigation)
    }
    
}
