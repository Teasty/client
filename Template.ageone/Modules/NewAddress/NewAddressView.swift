//
//  NewAddress.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class NewAddressView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = NewAddressViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NewAddressViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension NewAddressView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.register(RowFieldText.self)
        bodyTable.register(RowButton.self)
    }
    
    fileprivate func bindUI() {
    }
    
}

// MARK: Factory

extension NewAddressView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
        //        return viewModel.realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = reuse(tableView, indexPath, "RowFieldText") as? RowFieldText
            cell?.initialize(viewModel.model.name, "Введите название")
            cell?.textField.defineType(MaterialTextField.Types.text)
            cell?.onTextEntered = { [unowned self] value in
                self.viewModel.model.name = value
            }
            return cell!
        case 1:
            let cell = reuse(tableView, indexPath, "RowFieldText") as? RowFieldText
            var address = "\(viewModel.model.address.street) \(viewModel.model.address.home)"
            address = address.count == 1 ? "" : address
            cell?.initialize(address, "Введите адрес")
            cell?.textField.defineType(MaterialTextField.Types.address)
            cell?.textField.onAddressSelected = { [unowned self] address in
                self.viewModel.model.address = address
                DispatchQueue.main.async {
                    let accurancy2 = Accurancy2View()
                    accurancy2.onSelect = { value in
                        log.verbose(value)
                        let adr = "\(self.viewModel.model.address.country), город \(self.viewModel.model.address.city), \( self.viewModel.model.address.street) \(value)"
                        utils.googleMapKit.getAddressFromLatLong(address: adr, completion: { accAddress in
                            self.viewModel.model.address = accAddress
                            self.reload()
                        })
                    }
                    utils.controller()?.present(accurancy2, animated: true, completion: {
                        if let filed = accurancy2.bodyTable.cellForRow(at: IndexPath(row: 0, section: 0)) as? RowFieldText {
                            filed.textField.becomeFirstResponder()
                        }
                    })
                }
            }
            return cell!
        default:
            let cell = reuse(tableView, indexPath, "RowButton") as? RowButton
            cell?.initialize("Добавить")
            cell?.button.onTap = { [unowned self] in
                self.viewModel.createFavorite {
                    self.viewModel.model.address = GoogleMapKit.Address()
                    self.viewModel.model.name = ""
                    router.popToRoot()
                }
            }
            return cell!
        }
    }
    
}
