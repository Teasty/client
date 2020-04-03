//
//  Accurancy2.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 27/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class Accurancy2View: BaseController {
    
    public var onSelect: ((String) -> Void)?
    
    // MARK: viewModel
    
    public var viewModel = Accurancy2ViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Accurancy2ViewModel.Localization.title
        renderUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension Accurancy2View {
    
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

extension Accurancy2View: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
//        return viewModel.realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = reuse(tableView, indexPath, "RowFieldText") as? RowFieldText
            cell?.textField.defineType(MaterialTextField.Types.text)
            cell?.initialize("", "Номер дома")
            cell?.textField.onTextEntered = { [unowned self] value in
                self.viewModel.model.home = value
            }
            return cell!
            
        default:
            let cell = reuse(tableView, indexPath, "RowButton") as? RowButton
            cell?.initialize("Готово")
            cell?.button.onTap = { [unowned self] in
                self.onSelect?(self.viewModel.model.home)
                self.dismiss(animated: true)
            }
            return cell!
        }
    }
    
}
