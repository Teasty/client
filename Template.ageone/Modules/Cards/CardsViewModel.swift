//
//  Cards.swift
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

extension CardsViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish
    }
}

// MARK: Initialize

extension CardsViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? CardsModel else { unwarpError(); return }; model = unwarp
        loadRealmData()
//        bindRealm()
        insertCash()
        completion()
    }
}

// MARK: View Model

final class CardsViewModel: BaseViewModel, ViewModelProtocol {
    
    // MARK: Factory   -   [activate loadRealmData() in initialize]
    
    public var realmData = [Payment]()
    public func factory(_ index: IndexPath) -> Payment {
        return realmData[index.row]
    }
    fileprivate func loadRealmData() {
        realmData = utils.realm.payment.getObjects()
    }
    
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

    public var model = CardsModel()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Способ оплаты"
    }
    
    // MARK: private
    
    public func insertCash() {
        user.info.paymentType = "cash"
//        if user.info.payments.isEmpty {
//            user.info.payments.append("cash")
//        }
    }
    
    // MARK: public
    
    public func cardAction(_ index: Int) {
        let alert = alertAction.create("Вы действительно хотите удалить карту?", "")
        alert.addAction(UIAlertAction(title: "Выбрать в качестве оплаты", style: UIAlertAction.Style.default, handler: { _ in
//            user.info.paymentsSelected = index
        }))
        alert.addAction(UIAlertAction(title: "Удалить карту", style: UIAlertAction.Style.destructive, handler: { [unowned self] _ in
            self.cardDelete(index)
        }))
        alertAction.show(alert)
    }
    
    public func cardDelete(_ index: Int) {
        let alert = alertAction.create("Вы действительно хотите удалить карту?", "")
        alert.addAction(UIAlertAction(title: "Удалить", style: UIAlertAction.Style.destructive, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: { _ in
            
        }))
        alertAction.show(alert)
    }
    
}

// MARK: Model

class CardsModel: ModelProtocol {
    
}
