//
//  FlowLoading.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation

// MARK: Flow Model

final class FlowLoadingModels {
    fileprivate var modelLoading = LoadingModel()
}

// MARK: Flow

final class FlowLoading: BaseFlow {
    
    fileprivate var models = FlowLoadingModels()
    
    // MARK: override
    
    override func start() {
        moduleLoading(.replace)
    }
    
}

// MARK: Modules

extension FlowLoading {
    
    // MARK: Loading
    
    fileprivate func moduleLoading(_ transition: Router.Transition) {
        let module = LoadingView()
        module.initialize(models.modelLoading)
        module.emitEvent = { [unowned self] event in
            self.models.modelLoading = module.viewModel.model
            switch LoadingViewModel.EventType.string(event) {
            case .onFinish?:
                module.isRootController = false
                module.clearResource()
                self.finish()
            case .none: self.eventError(event)
            }
        }
        setRootController(module)
        router.transition(transition, module)
    }
    
}
