//
//  Accurancy.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class AccurancyView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = AccurancyViewModel()
    
    // MARK: ovveride
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAutocomplite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = AccurancyViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension AccurancyView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.register(RowFieldText.self)
        bodyTable.register(RowButton.self)
    }
    
    fileprivate func bindUI() {
    }
    
    fileprivate func showAutocomplite() {
//        if rxData.order.value.porch.isEmpty {
//
//        }
        alertAction.actionSheet(
            title: "Укажите место подачи",
            actions: [
                AlertAction.ActionSheetElement(name: "Главный вход", value: "Главный вход"),
                AlertAction.ActionSheetElement(name: "К торцу", value: "К торцу"),
                AlertAction.ActionSheetElement(name: "Подъезд № 1", value: "Подъезд № 1"),
                AlertAction.ActionSheetElement(name: "Подъезд № 2", value: "Подъезд № 2"),
                AlertAction.ActionSheetElement(name: "Подъезд № 3", value: "Подъезд № 3"),
                AlertAction.ActionSheetElement(name: "Подъезд № 4", value: "Подъезд № 4"),
                AlertAction.ActionSheetElement(name: "Подъезд № 5", value: "Подъезд № 5"),
                AlertAction.ActionSheetElement(name: "Подъезд № 6", value: "Подъезд № 6"),
                AlertAction.ActionSheetElement(name: "Подъезд № 7", value: "Подъезд № 7"),
                AlertAction.ActionSheetElement(name: "Подъезд № 8", value: "Подъезд № 8")
            ],
            selected: "",
            completion: { [unowned self] (value) in
                if value != "other" {
                    var order = rxData.order.value
                    order.porch = value
                    rxData.order.accept(order)
                }
                self.reload()
        })
    }
    
}

// MARK: Factory

extension AccurancyView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
        //        return viewModel.realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = reuse(tableView, indexPath, "RowFieldText") as? RowFieldText
            cell?.textField.defineType(MaterialTextField.Types.text)
            cell?.initialize(rxData.order.value.from.home, "Номер дома")
            cell?.textField.onTextEntered = { value in
                var order = rxData.order.value
                order.from.home = value
                rxData.order.accept(order)
            }
            return cell!
        
        case 1:
            let cell = reuse(tableView, indexPath, "RowFieldText") as? RowFieldText
            cell?.textField.defineType(MaterialTextField.Types.text)
            cell?.initialize(rxData.order.value.porch, "Место встречи, вход")
            cell?.textField.onTextEntered = { value in
                var order = rxData.order.value
                order.porch = value
                rxData.order.accept(order)
            }
            return cell!
            
        default:
            let cell = reuse(tableView, indexPath, "RowButton") as? RowButton
            cell?.initialize("Готово")
            cell?.button.onTap = { [unowned self] in
                self.viewModel.validate {
                    rxData.state.accept(RxData.StateType.destination)
                    self.emitEvent?(AccurancyViewModel.EventType.onFinish.rawValue)
                }
            }
            return cell!
        }
        
    }
    
}
