//
//  Cards.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 01/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Foundation

// MARK: Flow Model

final class FlowCardsModels {
    fileprivate var modelCard2 = Card2Model()
}

// MARK: Flow

final class FlowCards: BaseFlow {
    fileprivate var models = FlowCardsModels()
    override func start() {
        moduleCard2(.replace)
    }
}

// MARK: Modules

extension FlowCards {
    
    
    // MARK: Card2
    
    fileprivate func moduleCard2(_ transition: Router.Transition) {
        let module = Card2View()
        module.viewModel.initialize(models.modelCard2) { module.reload() }
        // module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelCard2 = module.viewModel.model
            switch Card2ViewModel.EventType(rawValue: event) {
            case .onFinish?: break
            case .none: self.eventError(event)
            }
        }
        module.setDismissButton()
        setRootController(module)
        setNavigationController()
//        router.transition(transition, module)
    }
    
    // MARK: Root Module - Cards
    
//    fileprivate func moduleCards(_ transition: Router.Transition) {
//        let module = CardsView()
//        module.viewModel.initialize(models.modelCards) { module.reload() }
////        module.onMoveToParent = { [unowned self] in self.finish() }
////        module.emitEvent = { [unowned self] event in
////            self.models.modelCards = module.viewModel.model
////            switch CardsViewModel.EventType(rawValue: event) {
////            case .onFinish?:
////                log.verbose("here22")
////                self.finish()
////            case .none: self.eventError(event)
////            }
////        }
//        module.setDismissButton()
//        setRootController(module)
//        setNavigationController()
////        coordinator.setSideMenuButton(navigation)
////        router.transition(transition, navigation)
//    }
    
}
