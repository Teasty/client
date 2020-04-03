//
//  ArticleList.swift
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

extension ArticleListViewModel {
    public enum EventType: String, CaseIterable {
        case onFinish
        case onSelected
    }
}

// MARK: Initialize

extension ArticleListViewModel {
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? ArticleListModel else { unwarpError(); return }; model = unwarp
        loadRealmData()
//        bindRealm()
        completion()
    }
}

// MARK: View Model

final class ArticleListViewModel: BaseViewModel, ViewModelProtocol {

    // MARK: Factory   -   [activate loadRealmData() in initialize]
    
    public var realmData = [Document]()
    public func factory(_ index: IndexPath) -> Document {
        return realmData[index.row]
    }
    fileprivate func loadRealmData() {
        realmData = utils.realm.document.getObjects()
        log.verbose(realmData)
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

    public var model = ArticleListModel()
    public var numberOfRows = Int()
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "О приложении"
    }
    
    // MARK: private
    
    // MARK: public
    
}

// MARK: Model

class ArticleListModel: ModelProtocol {
    public var selectedArticle = Document()
}
