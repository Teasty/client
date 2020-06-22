//
//  ArticleList.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class ArticleListView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = ArticleListViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ArticleListViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension ArticleListView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.register(RowSelector.self)
    }
    
    fileprivate func bindUI() {
    }
    
}

// MARK: Factory

extension ArticleListView: UITableViewDelegate, UITableViewDataSource {
    
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
            cell.textLabel?.text = "Веб-сайт"
            cell.accessoryType = .disclosureIndicator
            return cell
        
        default:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "AtticleCellDefault")
            cell.textLabel?.text = "Версия приложения: 1.3"
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let controller = LicenseView()
            present(controller, animated: true, completion: {})
        case 1:
            guard let url = URL(string: "http://www.taxi-snejok.ru") else { return }
            UIApplication.shared.open(url)
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
