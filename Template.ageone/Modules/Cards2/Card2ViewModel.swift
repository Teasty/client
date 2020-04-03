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
        bindRealm()
        completion()
    }
}

// MARK: View Model

final class Card2ViewModel: BaseViewModel, ViewModelProtocol {
    
    // MARK: Factory   -   [activate loadRealmData() in initialize]
    
    public var realmData = [Payment]()
    public func factory(_ index: IndexPath) -> Payment {
        return realmData[index.row]
    }
    fileprivate func loadRealmData() {
        realmData = utils.realm.payment.getObjects()
    }
    
    // MARK: Observable Realm   -   [activate bindRealm() in initialize]
    
    fileprivate func bindRealm() {
        Observable
            .array(from: utils.realm.payment.getResults())
            .subscribe(onNext: { [unowned self] _ in
                self.loadRealmData()
                self.onRealmUpdate?()
            })
            .disposed(by: disposeBag)
    }

    public var model = Card2Model()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Card2.Title".localized()
    }
    
    // MARK: private
    
    // MARK: public
    
    public func cardAction(_ card: Payment, completion: @escaping () -> Void) {
        let alert = alertAction.create("Вы действительно хотите удалить карту?", "")
        alert.addAction(UIAlertAction(title: "Выбрать в качестве оплаты", style: UIAlertAction.Style.default, handler: { [unowned self] _ in
            self.model.paymentType = card.hashId
            completion()
        }))
        alert.addAction(UIAlertAction(title: "Удалить карту", style: UIAlertAction.Style.destructive, handler: { [unowned self] _ in
            self.cardDelete(card, completion: {
                completion()
            })
        }))
        alertAction.show(alert)
    }
    
    public func cardDelete(_ card: Payment, completion: @escaping () -> Void) {
        let alert = alertAction.create("Вы действительно хотите удалить карту?", "")
        alert.addAction(UIAlertAction(title: "Удалить", style: UIAlertAction.Style.destructive, handler: { [unowned self] _ in
            if self.model.paymentType == card.hashId {
                alertAction.message("Нельзя удалить выбранную карту, выберите иной способ оплаты сначала")
            } else {

                let realm = try! Realm()
                try! realm.write {
                    if let c = realm.object(ofType: Payment.self, forPrimaryKey: card.hashId) {
                        c.isExist = false
                        realm.add(c, update: true)
                    }
                }
//                loading.show()
//                database.payment.delete(card.hashId)
//                firstly {
//                    api.requestMainLoad()
//                }.done { _ in
//                    let tmp = user.info.paymentType
//                    user.info.paymentType = tmp
//                    loading.hide()
//                    completion()
//                }.catch { (error) in
//                    log.error("Error detected: \(error)")
//                }
                completion()
            }
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
