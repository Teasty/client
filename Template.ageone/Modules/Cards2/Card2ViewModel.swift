//
//  Card2.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 03/06/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxCocoa
import RxSwift
import PromiseKit
import RealmSwift

// MARK: Events

extension Card2ViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish
    }
}

// MARK: Initialize

extension Card2ViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? Card2Model else { unwarpError(); return }; model = unwarp
        loadRealmData()
        if model.paymentType.isEmpty {
            model.paymentType = "cash"
        }
        log.error(model.paymentType)
        bindRealm()
        completion()
    }
}

// MARK: View Model

final class Card2ViewModel: BaseViewModel, ViewModelProtocol {
    
    // MARK: Factory   -   [activate loadRealmData() in initialize]
    
    public var realmData = [Card]()
    public func factory(_ index: IndexPath) -> Card {
        return realmData[index.row]
    }
    public func loadRealmData() {
        realmData = utils.realm.payment.getObjects()
        //        log.info(realmData)
    }
    
    // MARK: Observable Realm   -   [activate bindRealm() in initialize]
    
    fileprivate func bindRealm() {
        Observable
            .array(from: utils.realm.payment.getResults())
            .subscribe(onNext: { [unowned self] _ in
                self.onRealmUpdate?()
                self.loadRealmData()
                log.error(self.realmData)
            })
            .disposed(by: disposeBag)
    }
    
    public var model = Card2Model()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title = "Card2.Title".localized()
    }
    
    // MARK: private
    
    // MARK: public
    
    public func cardAction(_ card: Card, completion: @escaping () -> Void) {
        let alert = alertAction.create("Вы действительно хотите удалить карту?", "")
        alert.addAction(UIAlertAction(title: "Выбрать в качестве оплаты", style: UIAlertAction.Style.default, handler: { [unowned self] _ in
            api.request([
                "router": "togglePaymentType",
                "paymentData": card.hashId
                ], completion: { json in
                    api.parcer.userData(json["User"])
                    self.model.paymentType = card.hashId
                    completion()
            })
            
            
        }))
        alert.addAction(UIAlertAction(title: "Удалить карту", style: UIAlertAction.Style.destructive, handler: { [unowned self] _ in
            self.cardDelete(card, completion: {
                completion()
            })
        }))
        alertAction.show(alert)
    }
    
    public func cardDelete(_ card: Card, completion: @escaping () -> Void) {
        let alert = alertAction.create("Вы действительно хотите удалить карту?", "")
        alert.addAction(UIAlertAction(title: "Удалить", style: UIAlertAction.Style.destructive, handler: { [unowned self] _ in
            
            
            let realm = try! Realm()
            try! realm.write {
                if let c = realm.object(ofType: Card.self, forPrimaryKey: card.hashId) {
                    c.isExist = false
                    realm.add(c, update: true)
                }
            }
            api.request([
                "router": "deleteCard",
                "cardHashId": card.hashId
                ], completion: { json in
                    api.parcer.userData(json["User"])
                    if user.info.paymentType == "cash" {
                        self.model.paymentType = "cash"
                    } else {
                        self.model.paymentType = user.info.paymentType
                    }
                    completion()
            })
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: { _ in
            
        }))
        alertAction.show(alert)
    }
    
}

// MARK: Model

class Card2Model: ModelProtocol {
    var paymentType = user.info.paymentType
}
