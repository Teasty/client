//
//  History.swift
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

extension HistoryViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish
    }
}

// MARK: Initialize

extension HistoryViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? HistoryModel else { unwarpError(); return }; model = unwarp
        loadRealmData()
        bindRealm()
        completion()
    }
}

// MARK: View Model

final class HistoryViewModel: BaseViewModel, ViewModelProtocol {
    
    // MARK: Factory   -   [activate loadRealmData() in initialize]
    
    public var realmData = [Order]()
    fileprivate func loadRealmData() {
        realmData = utils.realm.order.getObjects().sorted(by: { (o1, o2) -> Bool in
            o1.created > o2.created
        })
//        log.info(realmData)
    }
    
    // MARK: Observable Realm   -   [activate bindRealm() in initialize]
    
    fileprivate func bindRealm() {
        Observable
            .array(from: utils.realm.order.getResults())
            .subscribe(onNext: { [unowned self] _ in
                self.loadRealmData()
                self.onRealmUpdate?()
            })
            .disposed(by: disposeBag)
    }

    public var model = HistoryModel()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "История поездок"
    }
    
    // MARK: private
    
    // MARK: public
    
}

// MARK: Model

class HistoryModel: ModelProtocol {
    
}
