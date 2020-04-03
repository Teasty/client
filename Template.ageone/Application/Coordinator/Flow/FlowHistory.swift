//
//  History.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 01/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Foundation

// MARK: Flow Model

final class FlowHistoryModels {
    fileprivate var modelHistory = HistoryModel()
}

// MARK: Flow

final class FlowHistory: BaseFlow {
    fileprivate var models = FlowHistoryModels()
    override func start() {
        moduleHistory(.replace)
    }
}

// MARK: Modules

extension FlowHistory {
    
    // MARK: Root Module - History
    
    fileprivate func moduleHistory(_ transition: Router.Transition) {
        let module = HistoryView()
        module.viewModel.initialize(models.modelHistory) { module.reload() }
//        module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelHistory = module.viewModel.model
            switch HistoryViewModel.EventType(rawValue: event) {
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
