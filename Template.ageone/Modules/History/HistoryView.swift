//
//  History.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class HistoryView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = HistoryViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = HistoryViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
}

// MARK: private

extension HistoryView {
    
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.register(HistoryBaseTableCell.self)
    }
    
    fileprivate func bindUI() {
        
    }
    
}

// MARK: Factory

extension HistoryView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.realmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = viewModel.realmData[indexPath.row]
        let cell = reuse(tableView, indexPath, "HistoryBaseTableCell") as? HistoryBaseTableCell
        cell?.initialize(order)
        cell?.buttonRepeat.onTap = { [unowned self] in
            if let addressFrom = order.departure, let addressTo = order.arrival {
                
                var rxOrder = rxData.order.value
                rxOrder.from.city = addressFrom.city
                rxOrder.from.street = addressFrom.street
                rxOrder.from.home = addressFrom.house
                rxOrder.from.lat = addressFrom.lat
                rxOrder.from.lng = addressFrom.lng
                rxOrder.porch = addressFrom.porch
                rxOrder.from.stringName = "\(addressFrom.street) \(addressFrom.house)"
                
                rxOrder.to.city = addressTo.city
                rxOrder.to.street = addressTo.street
                rxOrder.to.home = addressTo.house
                rxOrder.to.lat = addressTo.lat
                rxOrder.to.lng = addressTo.lng
                rxOrder.to.stringName = "\(addressTo.street) \(addressTo.house)"
                
                rxOrder.waypoints.removeAll()
                rxOrder.options.removeAll()
                rxOrder.comment.removeAll()
                rxOrder.change = "Под расчет"
                rxData.order.accept(rxOrder)
                loading.hide()
                rxData.state.accept(RxData.StateType.destination)
                self.dismiss(animated: true, completion: nil)
                api.requestPrice { }

                
                
                
//                loading.show()
//                utils.googleMapKit.geodecodeByCoordinatesByAPI(GoogleMapKit.Coordinates(lat: addressFrom.latitude, lng: addressFrom.longitude), completion: { [unowned self] addresParsedFrom in
//                    utils.googleMapKit.geodecodeByCoordinatesByAPI(GoogleMapKit.Coordinates(lat: addressTo.latitude, lng: addressTo.longitude), completion: { [unowned self] addresParsedTo in
//                        var rxOrder = rxData.order.value
//                        rxOrder.from = addresParsedFrom
//                        rxOrder.porch = addressFrom.porchNum
//                        rxOrder.to = addresParsedTo
//                        rxOrder.waypoints.removeAll()
//                        rxOrder.options.removeAll()
//                        rxData.order.accept(rxOrder)
//                        loading.hide()
//                        rxData.state.accept(RxData.StateType.destination)
//                        self.dismiss(animated: true, completion: nil)
//                        api.requestPrice { }
//                    })
//                })
            }
        }
        return cell!
    }
    
}
