//
//  Accurancy2.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 27/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxCocoa
import RxSwift
import PromiseKit
import RealmSwift

// MARK: Events

extension Accurancy2ViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish
    }
}

// MARK: Initialize

extension Accurancy2ViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? Accurancy2Model else { unwarpError(); return }; model = unwarp
//        loadRealmData()
//        bindRealm()
        completion()
    }
}

// MARK: View Model

final class Accurancy2ViewModel: BaseViewModel, ViewModelProtocol {
    
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

    public var model = Accurancy2Model()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Место подачи"
        static let error                     = "Укажите номер дома и место подачи"
    }
    
    // MARK: private
    
    public func validate(completion: @escaping () -> Void) {
        if rxData.order.value.from.home.isEmpty {
            alertAction.message(AccurancyViewModel.Localization.error)
            return
        }
        completion()
    }
    
    // MARK: public
    
}

// MARK: Model

class Accurancy2Model: ModelProtocol {
    var home = String()
}
