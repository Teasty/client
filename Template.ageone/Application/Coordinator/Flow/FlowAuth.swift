//
//  Auth.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 02/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Foundation

// MARK: Flow Model

final class FlowAuthModels {
    fileprivate var modelPhone = PhoneModel()
    fileprivate var modelArticle = ArticleModel()
    fileprivate var modelSMSCode = SMSCodeModel()
    fileprivate var modelEmail = EmailModel()
}

// MARK: Flow

final class FlowAuth: BaseFlow {
    fileprivate var models = FlowAuthModels()
    override func start() {
        modulePhone(.replace)
    }
}

// MARK: Modules

extension FlowAuth {
    
    // MARK: Root Module - Phone
    
    fileprivate func modulePhone(_ transition: Router.Transition) {
        let module = PhoneView()
        user.info.cacheTime = 0
        module.viewModel.initialize(models.modelPhone) { module.reload() }
//        module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelPhone = module.viewModel.model
            switch PhoneViewModel.EventType(rawValue: event) {
            case .onFinish?: self.finish()
            case .none: self.eventError(event)
            case .some(.onAgreementPressed): self.moduleArticle(.push)
            case .some(.onLogInButtonPressed): self.moduleSMSCode(.push)
            }
        }
        setRootController(module)
        setNavigationController()
//        coordinator.setSideMenuButton(module)
        router.transition(transition, navigation)
    }
    
    // MARK: Article
    
    fileprivate func moduleArticle(_ transition: Router.Transition) {
        let module = ArticleView()
        models.modelArticle.selectedArticle = models.modelPhone.selectedArticle
        module.viewModel.initialize(models.modelArticle) { module.reload() }
        // module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelArticle = module.viewModel.model
            switch ArticleViewModel.EventType(rawValue: event) {
            case .onFinish?: break
            case .none: self.eventError(event)
            }
        }
        router.transition(transition, module)
    }
    
    // MARK: SMSCode
    
    fileprivate func moduleSMSCode(_ transition: Router.Transition) {
        let module = SMSCodeView()
        models.modelSMSCode.phone = models.modelPhone.phone
        module.viewModel.initialize(models.modelSMSCode) { module.reload() }
        // module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelSMSCode = module.viewModel.model
            switch SMSCodeViewModel.EventType(rawValue: event) {
            case .onFinish?: break
            case .none: self.eventError(event)
            case .some(.onValidate): self.moduleEmail(.push)
            }
        }
        router.transition(transition, module)
    }
    
    // MARK: Email
    
    fileprivate func moduleEmail(_ transition: Router.Transition) {
        let module = EmailView()
        module.viewModel.initialize(models.modelEmail) { module.reload() }
        // module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelEmail = module.viewModel.model
            switch EmailViewModel.EventType(rawValue: event) {
            case .onFinish?: break
            case .none: self.eventError(event)
            case .some(.onValidate): self.finish()
            case .some(.onSkip): self.finish()
            }
        }
        router.transition(transition, module)
    }
    
}
