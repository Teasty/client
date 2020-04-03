//
//  Cards.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class CardsView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = CardsViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = CardsViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension CardsView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 20, right: 0)
        bodyTable.register(CardsBaseTableCell.self)
        bodyTable.register(RowButton.self)
        bodyTable.register(CardsCashTableCell.self)
    }
    
    fileprivate func bindUI() {
//        UserDefaults.standard.rx
//            .observe(String.self, "user_paymentType")
//            .subscribe(onNext: { [unowned self] _ in self.reload() })
//            .disposed(by: disposeBag)
//        UserDefaults.standard.rx
//            .observe(String.self, "user_paymentsSelected")
//            .subscribe(onNext: { [unowned self] _ in self.reload() })
//            .disposed(by: disposeBag)
    }
    
}

// MARK: Factory

extension CardsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.realmData.count + 2
        //        return viewModel.realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return BaseTableCell()
//        switch indexPath.row {
//        case viewModel.realmData.count:
//            let cell = reuse(tableView, indexPath, "CardsCashTableCell") as? CardsCashTableCell
//            cell?.initialize(user.info.paymentType == "cash")
//            cell?.onTap = {
////                user.info.paymentType = "cash"
//            }
//            return cell!
//
//        case viewModel.realmData.count + 1:
//            let cell = reuse(tableView, indexPath, "RowButton") as? RowButton
//            cell?.initialize("Добавить карту")
//            cell?.button.onTap = {
//                let parametrs: [String: Any] = [
//                    "router": "getRebillAnchor"
//                ]
//                api.request(parametrs, completion: { (json) in
//                    utils.openUrlInWebViewHTML(json["result"].stringValue)
//                })
//            }
//            return cell!
//
//        default:
//            let card = viewModel.realmData[indexPath.row]
//            let cell = reuse(tableView, indexPath, "CardsBaseTableCell") as? CardsBaseTableCell
//            cell?.initialize(card.lastCardDigits, user.info.paymentType == card.hashId)
//            cell?.onTap = {
////                user.info.paymentType = card.hashId
//            }
//            return cell!
//        }
    }
    
}
