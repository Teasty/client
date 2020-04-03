//
//  RxData.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 28/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

class RxData {
    
    var isDiscountShow = false
    var discount = Int()
    
    enum StateType: String, CaseIterable {
        case current
        case destination
        case to
        case created
        case waiting
        case accepted
        case onWay
        case arrived
    }
    public var state = BehaviorRelay.init(value: StateType.current)
    
    enum OrderTimeType: String, CaseIterable {
        case current
        case preliminary
    }
    
    struct OrderStruct {
        var from = GoogleMapKit.Address()
        var to = GoogleMapKit.Address()
        var waypoints = [GoogleMapKit.Address]()
        var porch = String()
        var time = Date()
        var timeType = OrderTimeType.current
        var comment = String()
        var options: [WishList: WishListValue] = [:]
        var tariff = Tariff()
        var change: String = "Под расчёт"
        var basePrice = Double()
        var price = Double()
    }
    
    public var order = BehaviorRelay.init(value: OrderStruct())
    
    public func calculatePrice() -> Int {
        if rxData.order.value.basePrice == 0.0 {
            return 0
        }
        
        var price = rxData.order.value.basePrice * rxData.order.value.tariff.coefficient - Double(rxData.order.value.tariff.fixedModifier)
        
        if rxData.order.value.tariff.coefficient > 1 {
            
            price = round(price / 10) * 10
            
            // MARK: round
            
            if price > 100 {
                price = Double(Int(price / 10) * 10)
            }
            
        }
        
        for e in rxData.order.value.options {
            price += e.value.price
        }
        
        if rxData.discount == 0 {
            return Int(price)
        }
        
//        return  Int(rxData.discount * (1 - rxData.discount / 100))
        
        return Int(price) - rxData.discount
    }
    
    public var carOnMap = BehaviorRelay.init(value: [CarOnMap]())
    
    public var state2 = ObservableVariable.init(StateType.current)
    public var carOnMap2 = ObservableVariable.init([CarOnMap]())
    
//    fileprivate func startWatchingDriver() {
//        if let driver = rxData.currentOrder?.driver {
//            socket.stopWatchingDriver()
//            socket.chooseCertainDriver(driverId: "\(driver.hashId);RED")
//        }
//    }
    
    public func isNeedCalcRidePrice() -> Bool {
        if (!(rxData.currentOrder?.__status == "") || rxData.currentOrder?.__status == "") || rxData.currentOrder?.__status == "" {
            return false
        }
        if let _ = rxData.currentOrder?.arrival, let _ = rxData.currentOrder?.departure {
            return false
        }
        return true
    }
    
//    "OrderType": {
//    "created": "Создан клиентом",
//    "cancelled": "Отменён клиентом",
//    "accepted": "Заказ принят водителем",
//    "waitingForClient": "Ожидаю клиента",
//    "onWay": "В пути",
//    "arrived": "Прибыли"
//    },
    
    public func checkCurrentOrder() {
        if let order = utils.realm.order.getObjects().filter({$0.__status != "cancelled" && !$0.isIOSFinish}).first {
//            log.verbose(order.__status)
            rxData.currentOrder = order
            switch order.__status {
            case "created":
                rxData.state.accept(RxData.StateType.created)
            case "accepted":
                loading.hide()
                rxData.state.accept(RxData.StateType.accepted)
            case "onWay":
                rxData.state.accept(RxData.StateType.onWay)
//                startWatchingDriver()
            case "waitingForClient":
                rxData.state.accept(RxData.StateType.waiting)
//                startWatchingDriver()
            case "arrived":
                rxData.state.accept(RxData.StateType.arrived)
            default: break
            }
        } else {
            if rxData.order.value.from.street.isEmpty {
                rxData.state.accept(RxData.StateType.current)
            } else {
                rxData.state.accept(RxData.StateType.destination)
            }
        }
        log.verbose(rxData.currentOrder)
    }
    
    public var currentOrder: Order?

    ///////////////////////////////////////////////////////////////////////
    ///  This function converts decimal degrees to radians              ///
    ///////////////////////////////////////////////////////////////////////
    func deg2rad(deg: Double) -> Double {
        return deg * .pi / 180
    }
    
    ///////////////////////////////////////////////////////////////////////
    ///  This function converts radians to decimal degrees              ///
    ///////////////////////////////////////////////////////////////////////
    func rad2deg(rad: Double) -> Double {
        return rad * 180.0 / .pi
    }
    
    func calculateDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double, unit: String = "K") -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist = dist * 60 * 1.1515
        if unit == "K" {
            dist *= 1.609344
        } else if unit == "N" {
            dist *= 0.8684
        }
        return dist * 1000
    }
    
}

class ObservableVariable {
    public var onChange: (() -> Void)?
    public var value: Any
    init<T>(_ initValue: T) {
        value = initValue
    }
    public func accept<T>(_ newValue: T) {
        value = newValue
        onChange?()
    }
}
