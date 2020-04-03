//
//  Accurancy.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 04/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Foundation

// MARK: Flow Model

final class FlowAccurancyModels {
    fileprivate var modelAccurancy = AccurancyModel()
}

// MARK: Flow

final class FlowAccurancy: BaseFlow {
    fileprivate var models = FlowAccurancyModels()
    override func start() {
        moduleAccurancy(.present)
    }
}

// MARK: Modules

extension FlowAccurancy {
    
    // MARK: Root Module - Accurancy
    
    fileprivate func moduleAccurancy(_ transition: Router.Transition) {
        let module = AccurancyView()
        module.viewModel.initialize(models.modelAccurancy) { module.reload() }
//        module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelAccurancy = module.viewModel.model
            switch AccurancyViewModel.EventType(rawValue: event) {
            case .onFinish?:
                module.dismiss(animated: true, completion: nil)
                self.finish()
            case .none: self.eventError(event)
            }
        }
        setRootController(module)
        setNavigationController()
//        coordinator.setSideMenuButton(module)
        router.transition(transition, navigation)
    }
    
}
