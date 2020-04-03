//
//  Card2.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 03/06/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class Card2View: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = Card2ViewModel()
    
    // MARK: ovveride
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        user.info.paymentType = viewModel.model.paymentType
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        user.info.paymentType = viewModel.model.paymentType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Способ оплаты"
        renderUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension Card2View {
    
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
        UserDefaults.standard.rx
            .observe(String.self, "user_paymentType")
            .subscribe(onNext: { [unowned self] value in
                log.verbose(value)
//                self.viewModel.model.paymentType = user.info.paymentType
                self.reload()
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: Factory

extension Card2View: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viewModel.numberOfRows + 2
        return viewModel.realmData.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = reuse(tableView, indexPath, "CardsCashTableCell") as? CardsCashTableCell
            cell?.initialize(viewModel.model.paymentType == "cash")
            cell?.onTap = { [unowned self] in
                self.viewModel.model.paymentType = "cash"
                self.reload()
            }
            return cell!
        case viewModel.realmData.count + 1:
            let cell = reuse(tableView, indexPath, "RowButton") as? RowButton
            cell?.initialize("Добавить карту")
            cell?.button.onTap = {
                DispatchQueue.main.async {
                    alertAction.message("Информация", "Данный раздел находится в разработке", fButtonName: "Ок", fButtonAction: {
                    })
                }
            }
            return cell!
        default:
            let cellData = viewModel.realmData[indexPath.row - 1]
            let cell = reuse(tableView, indexPath, "CardsBaseTableCell") as? CardsBaseTableCell
            cell?.initialize(cellData.lastCardDigits, viewModel.model.paymentType == cellData.hashId)
            cell?.onTap = { [unowned self] in
                self.viewModel.cardAction(cellData, completion: { [unowned self] in
                    self.reload()
                })
//                self.viewModel.model.paymentType = cellData.hashId
//                self.reload()
            }
            return cell!
        }
//        return BaseTableCell()
    }
    
}
