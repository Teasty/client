//
//  Accurancy.swift
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

extension AccurancyViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish
    }
}

// MARK: Initialize

extension AccurancyViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? AccurancyModel else { unwarpError(); return }; model = unwarp
//        loadRealmData()
//        bindRealm()
        completion()
    }
}

// MARK: View Model

final class AccurancyViewModel: BaseViewModel, ViewModelProtocol {
    
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

    public var model = AccurancyModel()
    public var numberOfRows = 3
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Место подачи"
        static let error                     = "Укажите номер дома и место подачи"
    }
    
    // MARK: private
    
    // MARK: public
    
    public func validate(completion: @escaping () -> Void) {
        if rxData.order.value.from.home.isEmpty || rxData.order.value.porch.isEmpty {
            alertAction.message(AccurancyViewModel.Localization.error)
            return
        }
        completion()
    }
    
}

// MARK: Model

class AccurancyModel: ModelProtocol {
    public var home = String()
    public var porch = String()
}
