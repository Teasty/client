//
//  Phone.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 02/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxCocoa
import RxSwift
import PromiseKit
import RealmSwift

// MARK: Events

extension PhoneViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish, onAgreementPressed, onLogInButtonPressed
    }
}

// MARK: Initialize

extension PhoneViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? PhoneModel else { unwarpError(); return }; model = unwarp
//        loadRealmData()
//        bindRealm()
        completion()
    }
}

// MARK: View Model

final class PhoneViewModel: BaseViewModel, ViewModelProtocol {
    
    // MARK: Factory   -   [activate loadRealmData() in initialize]
    
//    public var realmData = [<# RealmClass #>]()
//    public func factory(_ index: IndexPath) -> Document {
//        return realmData[index.row]
//    }
//    fileprivate func loadRealmData() {
//        realmData = utils.realm.<# RealmClass #>.getObjects()
//    }
    
    // MARK: Observable Realm   -   [activate bindRealm() in initialize]
    
//    fileprivate func bindRealm() {
//        Observable
//            .array(from: utils.realm.<# object #>.getResults())
//            .subscribe(onNext: { [unowned self] _ in
//                self.loadRealmData()
//                self.onRealmUpdate?()
//            })
//            .disposed(by: disposeBag)
//    }

    public var model = PhoneModel()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Авторизация"
        static let description               = "Введите Ваш номер телефона, на который мы вышлем смс код для верефикации"
        static let agreementText             = "Нажимая на кнопку “Далее”, я соглашаюсь с"
        static let agreementButton           = "данными лицензионного соглашения"
        static let button                    = "Далее"
        static let placeholder               = "Номер телефона"
        static let error                     = "Неверный номер"
    }
    
    // MARK: public
    
    public func validate(completion: @escaping () -> Void) {
        if !utils.validation.phone(model.phone) {
            alertAction.message(PhoneViewModel.Localization.error)
            return
        }
        requestSMSCode {
            completion()
        }
    }
    
    public func requestSMSCode(completion: @escaping () -> Void) {
        loading.show()
        var phone = model.phone
        _ = phone.remove(at: model.phone.startIndex)
        api.request([
            "router": "phoneAuth",
            "phone": String(phone)
        ], true) { _ in 
            user.phone = phone
            loading.hide()
            completion()
        }
    }
    
    public func setArticle(completion: @escaping () -> Void) {
        if let offer = utils.realm.document.getObjects().filter({$0.__type == "offer"}).first {
            model.selectedArticle = offer
            completion()
        }
    }
    
}

// MARK: Model

class PhoneModel: ModelProtocol {
    public var phone = String()
    public var selectedArticle = Document()
}
