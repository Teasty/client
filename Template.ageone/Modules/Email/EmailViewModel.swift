//
//  Email.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxCocoa
import RxSwift
import PromiseKit
import RealmSwift

// MARK: Events

extension EmailViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish, onValidate, onSkip
    }
}

// MARK: Initialize

extension EmailViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? EmailModel else { unwarpError(); return }; model = unwarp
        //        loadRealmData()
        //        bindRealm()
        completion()
    }
}

// MARK: View Model

final class EmailViewModel: BaseViewModel, ViewModelProtocol {
    
    
    public var model = EmailModel()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Авторизация"
        static let placeholder               = "Адрес электронной почты"
        static let description               = "Укажите адрес электоронной почты, и мы будем отправлять Вам электронные квитанции о совершенных поездках."
        static let cancel                    = "Если вы не хотите получать квитанцию о поездках на почту"
        static let cancelButton              = "подтвердите свой отказ"
        static let button                    = "Далее"
        static let error                     = "Неверный email"
    }
    
    // MARK: private
    
    // MARK: public
    
    public func validate(completion: @escaping () -> Void) {
        if utils.validation.email(model.email) {
            user.email = self.model.email
            user.isAutorized = true
            completion()
        } else {
            alertAction.message(EmailViewModel.Localization.error)
        }
    }
    
    public func skipEmail(completion: @escaping () -> Void) {
        user.isAutorized = true
        completion()
    }
    
}

// MARK: Model

class EmailModel: ModelProtocol {
    public var email = String()
}
