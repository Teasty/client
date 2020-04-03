//
//  Articles.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 02/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Foundation

// MARK: Flow Model

final class FlowArticlesModels {
    fileprivate var modelArticleList = ArticleListModel()
    fileprivate var modelArticle = ArticleModel()
}

// MARK: Flow

final class FlowArticles: BaseFlow {
    fileprivate var models = FlowArticlesModels()
    override func start() {
        moduleArticleList(.replace)
    }
}

// MARK: Modules

extension FlowArticles {
    
    // MARK: Root Module - ArticleList
    
    fileprivate func moduleArticleList(_ transition: Router.Transition) {
        let module = ArticleListView()
        module.viewModel.initialize(models.modelArticleList) { module.reload() }
//        module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelArticleList = module.viewModel.model
            switch ArticleListViewModel.EventType(rawValue: event) {
            case .onFinish?: self.finish()
            case .none: self.eventError(event) 
            case .some(.onSelected): self.moduleArticle(.push)
            }
        }
        module.setDismissButton()
        setRootController(module)
        setNavigationController()
        //        coordinator.setSideMenuButton(navigation)
        //        router.transition(transition, navigation)
    }
    
    // MARK: Article
    
    fileprivate func moduleArticle(_ transition: Router.Transition) {
        let module = ArticleView()
        models.modelArticle.selectedArticle = models.modelArticleList.selectedArticle
        module.viewModel.initialize(models.modelArticle) { module.reload() }
        // module.onMoveToParent = { [unowned self] in self.finish() }
        module.emitEvent = { [unowned self] event in self.models.modelArticle = module.viewModel.model
            switch ArticleViewModel.EventType(rawValue: event) {
            case .onFinish?: break
            case .none: self.eventError(event)
            }
        }
        router.transition(transition, module)
    }
}
