//
//  Lostes.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class LostesView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = LostesViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LostesViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension LostesView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.register(LostedBaseTableCell.self)
    }
    
    fileprivate func bindUI() {
    }
    
}

// MARK: Factory

extension LostesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
        //        return viewModel.realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reuse(tableView, indexPath, "LostedBaseTableCell") as? LostedBaseTableCell
        cell?.initialize()
        cell?.buttonPhone.onTap = {
            utils.makePhoneCall(number: "+78182275270")
        }
        return cell!
    }
    
}
