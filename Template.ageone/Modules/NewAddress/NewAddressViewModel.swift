//
//  NewAddress.swift
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

extension NewAddressViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish, onAddressAdd
    }
}

// MARK: Initialize

extension NewAddressViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? NewAddressModel else { unwarpError(); return }; model = unwarp
//        loadRealmData()
//        bindRealm()
        completion()
    }
}

// MARK: View Model

final class NewAddressViewModel: BaseViewModel, ViewModelProtocol {
    
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

    public var model = NewAddressModel()
    public var numberOfRows = 3
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Добавьте адрес"
        static let error                     = "Не все поля добавлены"
    }
    
    // MARK: private
    
    // MARK: public
    
    public func createFavorite(completion: @escaping () -> Void) {
        if model.address.street.isEmpty || model.name.isEmpty {
            alertAction.message(NewAddressViewModel.Localization.error)
            return
        }
        let realm = try! Realm()
        try! realm.write {
            let favorite = Favorite()
            favorite.hashId = UUID().uuidString
            favorite.name = model.name
            favorite.city = model.address.city
            favorite.country = model.address.country
            favorite.home = model.address.home
            favorite.lat = model.address.lat
            favorite.lng = model.address.lng
            favorite.postalCode = model.address.postalCode
            favorite.region = model.address.region
            favorite.street = model.address.street
            realm.add(favorite, update: true)
        }
        completion()
    }
    
}

// MARK: Model

class NewAddressModel: ModelProtocol {
    public var name = String()
    public var address = GoogleMapKit.Address()
}
