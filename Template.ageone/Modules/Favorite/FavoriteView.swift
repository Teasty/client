//
//  Favorite.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class FavoriteView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = FavoriteViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = FavoriteViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension FavoriteView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.register(FavoriteBaseTableCell.self)
        bodyTable.register(RowButton.self)
    }
    
    fileprivate func bindUI() {
        viewModel.onRealmUpdate = { [unowned self] in
            self.reload()
        }
    }
    
}

// MARK: Factory

extension FavoriteView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.realmData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case viewModel.realmData.count:
            let cell = reuse(tableView, indexPath, "RowButton") as? RowButton
            cell?.initialize("Добавить адрес")
            cell?.button.onTap = { [unowned self] in
                self.emitEvent?(FavoriteViewModel.EventType.addNewAddress.rawValue)
            }
            return cell!
        default:
            let cellData = viewModel.factory(indexPath)
            let cell = reuse(tableView, indexPath, "FavoriteBaseTableCell") as? FavoriteBaseTableCell
            let address = "\(cellData.street), \(cellData.home)"
            cell?.initialize(cellData.name, address)
            cell?.onTap = { [unowned self] in
                self.viewModel.select(cellData, completion: { [unowned self] in
                    var rxOrder = rxData.order.value
                    rxOrder.to.street = cellData.street
                    rxOrder.to.home = cellData.home
                    rxOrder.to.lat = cellData.lat
                    rxOrder.to.lng = cellData.lng
                    rxOrder.to.stringName = "\(cellData.street) \(cellData.home)"
                    self.emitEvent?(FavoriteViewModel.EventType.onSelect.rawValue)
                })
            }
            cell?.buttonCanel.onTap = { [unowned self] in
                self.viewModel.deleteFavorite(cellData, completion: { })
            }
            return cell!
        }
    }
    
}
