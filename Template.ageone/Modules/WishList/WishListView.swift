//
//  WishList.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class WishListView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = WishListViewModel()
    
    // MARK: ovveride
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bindUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = WishListViewModel.Localization.title
        renderUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension WishListView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 20, right: 0)
        bodyTable.register(WishListBaseTableCell.self)
        bodyTable.register(WishListCommentTableCell.self)
        bodyTable.register(WishListStaticTableCell.self)
        bodyTable.register(WishListUpCostTableCell.self)
    }
    
    fileprivate func bindUI() {
        rxData.order
            .asObservable()
            .bind { [unowned self] _ in
                self.reload()
        }.disposed(by: disposeBag)
    }
    
}

// MARK: Factory

extension WishListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.realmData.count + 3
        //        return viewModel.realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case viewModel.realmData.count:
            let cell = reuse(tableView, indexPath, "WishListStaticTableCell") as? WishListStaticTableCell
            cell?.initialize()
            return cell!
            
        case viewModel.realmData.count + 1:
            let cell = reuse(tableView, indexPath, "WishListUpCostTableCell") as? WishListUpCostTableCell
            cell?.initialize()
            return cell!
            
        case viewModel.realmData.count + 2:
            let cell = reuse(tableView, indexPath, "WishListCommentTableCell") as? WishListCommentTableCell
            cell?.initialize(rxData.order.value.comment)
            cell?.onTap = {
                let textViewIntput = TextViewIntput()
                textViewIntput.onFinish = { value in
                    var order = rxData.order.value
                    order.comment = value
                    rxData.order.accept(order)
                }
                textViewIntput.open(rxData.order.value.comment, "Комментарий водителю", "Комментарий")
            }
            return cell!
            
        default:
            let cellData = viewModel.factory(indexPath)
            let cell = reuse(tableView, indexPath, "WishListBaseTableCell") as? WishListBaseTableCell
            cell?.initialize(cellData)
            return cell!
        }
    }
    
}
