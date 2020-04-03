//
//  Favorite.swift
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

extension FavoriteViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish, addNewAddress, onSelect
    }
}

// MARK: Initialize

extension FavoriteViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? FavoriteModel else { unwarpError(); return }; model = unwarp
        loadRealmData()
        bindRealm()
        completion()
    }
}

// MARK: View Model

final class FavoriteViewModel: BaseViewModel, ViewModelProtocol {
    
    // MARK: Factory   -   [activate loadRealmData() in initialize]
    
    public var realmData = [Favorite]()
    public func factory(_ index: IndexPath) -> Favorite {
        return realmData[index.row]
    }
    fileprivate func loadRealmData() {
        let realm = try! Realm()
        realmData = Array(realm.objects(Favorite.self))
        log.info(realmData)
    }
    
    // MARK: Observable Realm   -   [activate bindRealm() in initialize]
    
    fileprivate func bindRealm() {
        let realm = try! Realm()
        Observable
            .array(from: realm.objects(Favorite.self))
            .subscribe(onNext: { [unowned self] _ in
                self.loadRealmData()
                self.onRealmUpdate?()
            })
            .disposed(by: disposeBag)
    }

    public var model = FavoriteModel()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Любимые адреса"
    }
    
    // MARK: private
    
    // MARK: public
    
    public func deleteFavorite(_ favorite: Favorite, completion: @escaping () -> Void) {
        let alert = alertAction.create("Вы действительно хотите удалить адреас?", "")
        alert.addAction(UIAlertAction(title: "Да", style: UIAlertAction.Style.default, handler: { _ in
            let realm = try! Realm()
            try! realm.write {
                realm.delete(favorite)
            }
            completion()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: nil))
        alertAction.show(alert)
    }
    
    public func select(_ favorite: Favorite, completion: @escaping () -> Void) {
        var order = rxData.order.value
        order.to.postalCode = favorite.postalCode
        order.to.country = favorite.country
        order.to.region = favorite.region
        order.to.city = favorite.city
        order.to.street = favorite.street
        order.to.home = favorite.home
        order.to.lat = favorite.lat
        order.to.lng = favorite.lng
        order.to.stringName = "\(favorite.street) \(favorite.home)"
        rxData.order.accept(order)
        completion()
    }
    
}

// MARK: Model

class FavoriteModel: ModelProtocol {
    
}
