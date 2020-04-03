//
//  AddressGoogle.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class AddressGoogleView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = AddressGoogleViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = AddressGoogleViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension AddressGoogleView {
    
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

extension AddressGoogleView: UITableViewDelegate, UITableViewDataSource {
    
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
