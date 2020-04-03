//
//  Mark.swift
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

extension MarkViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish
    }
}

// MARK: Initialize

extension MarkViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? MarkModel else { unwarpError(); return }; model = unwarp
//        loadRealmData()
//        bindRealm()
        completion()
    }
}

// MARK: View Model

final class MarkViewModel: BaseViewModel, ViewModelProtocol {
    
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

    public var model = MarkModel()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Mark.Title".localized()
    }
    
    // MARK: private
    
    // MARK: public
    
}

// MARK: Model

class MarkModel: ModelProtocol {
    
}
