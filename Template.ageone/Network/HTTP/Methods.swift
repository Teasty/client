//
//  Methods.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 21/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import PromiseKit
import Alamofire
import SwiftyJSON
import Firebase

// MARK: Custom API Methods

extension API {
    
    // MARK: Main load
    func requestMainLoad() -> Promise<Void> {
        log.info("mainLoad")
        return Promise { seal in
            let parametrs: [String: Any] = [
                "router": "mainLoad",
                "cacheTime": user.info.cacheTime
            ]
            api.request(parametrs, completion: { (json) in
                log.verbose(json)
                
                user.info.cacheTime = Int(Date().timeIntervalSince1970)
                for object in json {
                    log.verbose(api.parcer.parseAnyObject(object.0, object.1))
                }
                // MARK: - CheckCurrentOrder
                rxData.checkCurrentOrder()
                seal.fulfill_()
            })
        }
    }
    // MARK: Synchronization
    func requestSynchronization() -> Promise<Void> {
        return Promise { seal in
            let parametrs: [String: Any] = [
                "router": "synchronization",
                "cacheTime": user.info.cacheTime
            ]
            api.request(parametrs, completion: { (json) in
                //                log.verbose(json)
                
                api.parcer.parseOrder(json["currentOrder"])
                log.info(json["currentOrder"])
                
                // MARK: - CheckCurrentOrder
                rxData.checkCurrentOrder()
                seal.fulfill_()
            })
        }
    }
    // TODO: Синхронизация и мейнлоад разные данные!!!
    // MARK: Check auth
    public func checkAuth(completion: @escaping (Bool) -> Void) {
        let parametrs: [String: Any] = [
            "router": "checkAuth"
        ]
        api.request(parametrs) { json in
            //            log.verbose(json)
            if json != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    // MARK: Ask for Discount
    public func askForDiscount(completion: @escaping (Bool) -> Void) {
        let parametrs: [String: Any] = [
            "router": "checkDiscountRide"
        ]
        api.request(parametrs) { json in
            if json["isDiscountRide"] == true {
                completion(true)
            }
        }
    }
    
    
    // MARK: Send FCM token
    public func sendFCMToken(completion: @escaping () -> Void) {
        let parametrs: [String: Any] = [
            "router": "sendTokenFCM",
            "tokenFCM": user.tokenFCM
        ]
        api.request(parametrs) { json in
            log.verbose(json)
            completion()
        }
    }
    // MARK: Get FCM token
    public func getFCMToken() -> Promise<Void> {
        return Promise { seal in
            InstanceID.instanceID().instanceID { (result, error) in
                if let error = error {
                    log.error("Error fetching remote instance ID: \(error)")
                    seal.fulfill_()
                } else if let result = result {
                    log.info("Remote instance ID token: \(result.token)")
                    user.tokenFCM = result.token
                    seal.fulfill_()
                }
            }
        }
    }
    
    // MARK: Cancel order
    public func cancelOrder(_ orderHashId: String, completion: @escaping () -> Void) {
        let parametrs: [String: Any] = [
            "router": "cancelOrder",
            "orderHashId": orderHashId
        ]
        api.request(parametrs) { json in
            api.parcer.parseOrder(json["Order"])
            completion()
        }
    }
    // MARK: Create order
    public func createOrder(completion: @escaping () -> Void) {
        
        if rxData.order.value.to.street.isEmpty && rxData.order.value.to.stringName.isEmpty {
            alertAction.message("Ошибка заказа", "Вы не выбрали место назначения", fButtonName: "Ок") {
                loading.hide()
            }
            return
        }
        
        if rxData.order.value.basePrice == 0 || rxData.order.value.basePrice == 111 {
            alertAction.message("Ошибка заказа", "На данный момент мы не можем туда доехать", fButtonName: "Ок") {
                loading.hide()
            }
            return
        }
        
        if rxData.order.value.from.street.isEmpty && rxData.order.value.from.stringName.isEmpty {
            alertAction.message("Ошибка заказа", "Вы не выбрали место отправления", fButtonName: "Ок") {
                loading.hide()
            }
            return
        }
        
        //        if rxData.order.value.price == 0 {
        //            alertAction.message("Ошибка заказа", "Неверный адрес. Выберите другой.", fButtonName: "Ок") {
        //         loading.hide()
        //    }
        //            return
        //        }
        
         var wishes = [[String: String]]()
         for wish in rxData.order.value.options {
             var value = [String: String]()
             value["wishListHashId"] = wish.key.hashId
             value["wishListValueHashId"] = wish.value.hashId
             wishes.append(value)
         }
        
        var address = [[String: Any]]()
        if !rxData.order.value.from.street.isEmpty || !rxData.order.value.from.stringName.isEmpty {
            var value = [String: Any]()
            //            let adr = rxData.order.value.from.street.isEmpty ? rxData.order.value.from.stringName : "\(rxData.order.value.from.street) \(rxData.order.value.from.home)"
            //            value["address"] = adr
            value["city"] = rxData.order.value.from.city
            value["street"] = rxData.order.value.from.street.isEmpty ? rxData.order.value.from.stringName : rxData.order.value.from.street
            value["lat"] = rxData.order.value.from.lat
            value["lng"] = rxData.order.value.from.lng
            value["house"] = rxData.order.value.from.home
            value["porch"] = rxData.order.value.porch
            address.append(value)
        }
        //        log.info(rxData.order.value.waypoints)
        for waypoint in rxData.order.value.waypoints {
            if !waypoint.street.isEmpty {
                var value = [String : Any]()
                value["city"] = waypoint.city
                value["street"] = waypoint.street.isEmpty ? waypoint.stringName : waypoint.street
                value["lat"] = waypoint.lat
                value["lng"] = waypoint.lng
                value["house"] = waypoint.home
                value["porch"] = ""
                address.append(value)
            }
        }
        
        if !rxData.order.value.to.street.isEmpty || !rxData.order.value.to.stringName.isEmpty {
            var value = [String: Any]()
            //            let adr = rxData.order.value.to.street.isEmpty ? rxData.order.value.to.stringName : "\(rxData.order.value.to.street) \(rxData.order.value.to.home)"
            //            value["address"] = adr
            value["city"] = rxData.order.value.to.city
            value["street"] = rxData.order.value.to.street.isEmpty ? rxData.order.value.to.stringName : rxData.order.value.to.street
            value["lat"] = rxData.order.value.to.lat
            value["lng"] = rxData.order.value.to.lng
            value["house"] = rxData.order.value.to.home
            value["porch"] = ""
            address.append(value)
        }
        let changeArr = rxData.order.value.change.components(separatedBy: " ")
        let change = Int(changeArr[0]) ?? 0
        
        let parametrs: [String: Any] = [
            "router": "createOrder",
            "change": change,
            "tariffHashId": rxData.order.value.tariff.hashId,
            "timeRequired": Int(rxData.order.value.time.timeIntervalSince1970),
            "comment": rxData.order.value.comment,
            "price": rxData.order.value.basePrice,
            "paymentType": user.info.paymentType == "cash" ? "cash" : "card",
//            "isDiscountRide": false,
            "upCost": Double(rxData.order.value.upCost) ?? 0,
            "wishList": wishes,
            "addressList": address
        ]
//        log.verbose(JSON(arrayLiteral: parametrs))
        
        api.request(parametrs, true, completion: { (json) in
            log.info(api.parcer.parseOrder(json["Order"]))
//                log.verbose(json)
                rxData.checkCurrentOrder()
                completion()
            
        })
    }
    
    public func requestPrice(completion: @escaping () -> Void) {
        
        if rxData.order.value.to.street.isEmpty && rxData.order.value.to.stringName.isEmpty {
            return
        }
        
        DispatchQueue.main.async {
            var addresses = [[String: String]]()
            
            // MARK: From
            
            addresses.append([
                "street": rxData.order.value.from.street.isEmpty ? rxData.order.value.from.stringName : rxData.order.value.from.street,
                "house": rxData.order.value.from.home,
                "city": rxData.order.value.from.city
            ])
            
            // MARK: Waypoints
            
            for waypoint in rxData.order.value.waypoints {
                if !waypoint.street.isEmpty {
                    addresses.append([
                        "street": waypoint.street.isEmpty ? waypoint.stringName : waypoint.street,
                        "house": waypoint.home,
                        "city": waypoint.city
                    ])
                }
            }
            
            // MARK: To
            
            addresses.append([
                "street": rxData.order.value.to.street.isEmpty ? rxData.order.value.to.stringName : rxData.order.value.to.street,
                "house": rxData.order.value.to.home,
                "city": rxData.order.value.to.city
            ])
            
            var wishes = [String]()
            for wish in rxData.order.value.options {
                wishes.append(wish.value.hashId)
            }
            
            let parametrs: [String: Any] = [
                "router": "calcRidePrice",
                "tariffHashId": rxData.order.value.tariff.hashId,
                "addressList": addresses,
                "wishValueHashIdList": wishes,
                "upCost": Double(rxData.order.value.upCost) ?? 0
            ]
            log.verbose(JSON(arrayLiteral: parametrs))
            
            api.request(parametrs, completion: {response in
                if response != nil {
                    log.verbose(response)
                    var order = rxData.order.value
                    order.basePrice = response["ridePrice"].doubleValue
                    rxData.order.accept(order)
                    completion()
                }
            })
        }
        
    }
    
}
