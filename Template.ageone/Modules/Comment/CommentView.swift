//
//  Comment.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class CommentView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = CommentViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = CommentViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension CommentView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.register(BaseTableCell.self)
    }
    
    fileprivate func bindUI() {
    }
    
}

// MARK: Factory

extension CommentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
        //        return viewModel.realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cellData = viewModel.factory(indexPath)
        //        switch indexPath.row {
        //        case 1:
        //            let cell = reuse(tableView, indexPath, "<# name #>") as? <# name #>
        //            cell?.initialize()
        //            return cell!
        //        default: return BaseTableCell()
        //        }
        return BaseTableCell()
    }
    
}
