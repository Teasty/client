//
//  SMSCode.swift
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

extension SMSCodeViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish, onValidate
    }
}

// MARK: Initialize

extension SMSCodeViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? SMSCodeModel else { unwarpError(); return }; model = unwarp
//        loadRealmData()
//        bindRealm()
        startTimer()
        completion()
    }
}

// MARK: View Model

final class SMSCodeViewModel: BaseViewModel, ViewModelProtocol {
    
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

    public var model = SMSCodeModel()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Авторизация"
        static let description               = "Если Вы не получили смс, запросить код повторно можно через {timer}"
        static let button                    = "Далее"
        static let placeholder               = "СМС Код"
        static let retry                     = "Если Вы не получили смс, запросите смс код ещё раз"
        static let retrySelected             = "запросите смс код ещё раз"
        static let error                     = "СМС Код неверный"
    }
    
    // MARK: private
    
    fileprivate func startTimer() {
        let text = SMSCodeViewModel.Localization.description.replacingOccurrences(of: "{timer}", with: "\(model.counter)")
        model.description.accept(text)
        model.timer = CustomTimer(CustomTimer.Types.decrement, onCount: { count in
            let counter = String(format: "%02d", count)
            let text = SMSCodeViewModel.Localization.description.replacingOccurrences(of: "{timer}", with: "\(counter)")
            self.model.description.accept(text)
        })
        model.timer?.start(count: model.counter) {
            self.model.description.accept("\(SMSCodeViewModel.Localization.retry)")
        }
    }
    
    // MARK: public
    
    public func validate(completion: @escaping () -> Void) {
        if model.code.count != 4 {
            alertAction.message(SMSCodeViewModel.Localization.error)
            return
        }
        completion()
    }
    
    public func checkSMSCode(completion: @escaping () -> Void) {
        loading.show()
        api.request([
            "router": "codeCheck",
            "code": model.code,
            "phone": user.phone
        ], true) { [unowned self] json in
            api.parcer.userData(json["User"])
            
            let realm = try! Realm()
            let orders = realm.objects(Order.self)
            try! realm.write {
                realm.delete(orders)
            }
            
            api.sendFCMToken {
                loading.hide()
//                socket._init()
                completion()
            }
        }
    }
    
}

// MARK: Model

class SMSCodeModel: ModelProtocol {
    public var description = BehaviorRelay<String>(value: "")
    public var timer: CustomTimer?
    fileprivate var counter = 300
    public var code = String()
    public var phone = String()
}
