//
//  Article.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ArticleView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = ArticleViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = ArticleViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension ArticleView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.register(ArticleBaseTableCell.self)
    }
    
    fileprivate func bindUI() {
    }
    
}

// MARK: Factory

extension ArticleView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "AtticleCellDefault")
            cell.textLabel?.text = "Лицензионное соглашение"
            cell.accessoryType = .disclosureIndicator
            return cell
        case 1:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "AtticleCellDefault")
            cell.textLabel?.text = "Лицензионное соглашение"
            cell.accessoryType = .disclosureIndicator
            return cell
        
        default:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "AtticleCellDefault")
            cell.textLabel?.text = "build"
            return cell
        }
    }
}
