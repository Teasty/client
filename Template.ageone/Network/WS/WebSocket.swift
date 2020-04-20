//
//  WebSocket.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 21/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import SocketIO
import SwiftyJSON
import RealmSwift
import PromiseKit

import RxCocoa
import RxSwift
import RxRealm

class SocketIONetwork {
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate var manager: SocketManager? = nil
    public var socket: SocketIOClient? = nil
    
    var isConnected = false
    var needToSubscribe = true
    
    fileprivate var timer = Timer()
    
    init() {
        
    }
    
    public func clearSocket() {
        isConnected = false
        needToSubscribe = true
        socket?.removeAllHandlers()
    }
    
    public func _init() {
        
        manager = SocketManager(
            socketURL: URL(string: database.url)!,
            config: [
                .log(true),
                .forceNew(true),
                .reconnects(true),
                .compress
            ]
        )
        
        socket = manager!.defaultSocket
        
        socket?.on(clientEvent: .connect) { [unowned self] _, _ in
            self.isConnected = true
            self.registration()
            self.subscribeAll()
            self.startUpdatingLatLng()
            log.info("socket connected")
            api.checkAuth(completion: { isAuthorized in
                if isAuthorized {
                    _ = api.requestSynchronization()
                } else {
                    alertAction.showAppExitMessage("В Ваш аккаунт зашли с другого устройства. Перезайдите в приложение.")
                }
            })
        }
        
        //       TODO: wating for client
        
        socket?.on(clientEvent: .disconnect) { [unowned self] _, _ in
            self.isConnected = false
            self.stopUpdatingLatLng()
            log.info("socket disconnect")
            //            self.socket?.connect()
        }
        socket?.connect()
    }
    
    func subscribeAll() {
        if !needToSubscribe {
            return
        }
        needToSubscribe = false
        
        // MARK: Nearest Drivers
        socket?.on("nearestDrivers", callback: { (resp, _) in
            let json = JSON(resp)
            if let currentDriver = rxData.currentOrder?.driver {
                var cars = [CarOnMap]()
                for e in json[0] {
                    if currentDriver.hashId == e.1["driverHashId"].stringValue {
                        cars.append(CarOnMap(
                            lng: e.1["lng"].doubleValue.rounded(toPlaces: 5),
                            lat: e.1["lat"].doubleValue.rounded(toPlaces: 5),
                            color: e.1["carColor"].stringValue,
                            hashId: e.1["driverHashId"].stringValue)
                        )
                    }
                }
                rxData.carOnMap.accept(cars)
                rxData.carOnMap2.accept(cars)
            } else if rxData.state.value != .waiting {
                var cars = [CarOnMap]()
                for e in json[0] {
                    cars.append(CarOnMap(
                        lng: e.1["lng"].doubleValue.rounded(toPlaces: 5),
                        lat: e.1["lat"].doubleValue.rounded(toPlaces: 5),
                        color: e.1["carColor"].stringValue,
                        hashId: e.1["driverHashId"].stringValue)
                    )
                }
                rxData.carOnMap.accept(cars)
                rxData.carOnMap2.accept(cars)
            } else {
                rxData.carOnMap.accept([CarOnMap]())
                rxData.carOnMap2.accept([CarOnMap]())
            }
        }
        )
        
        // MARK: Same User Auth
        socket?.on("sameUserAuth", callback: { (_, _) in
            alertAction.showAppExitMessage("В Ваш аккаунт зашли с другого устройства. Перезайдите в приложение.")
        })
        
        // MARK: Arrived
        socket?.on("arrived", callback: { (resp, _) in
            guard let json = JSON(resp).first else {
                log.error("WebSocket can't parse server responce \(resp)")
                return
            }
            log.info("Socket: arrived")
            _ = api.parcer.parseOrder(json.1)
//            rxData.order.accept(RxData.OrderStruct())
            user.info.isNeedToShowRateOrderView = true
            user.info.rateOrderViewButtonIsTapped = false
            rxData.checkCurrentOrder()
        })
        
        // MARK: Accept Order
        socket?.on("acceptOrder", callback: { (resp, _) in
            guard let json = JSON(resp).first else {
                log.error("WebSocket can't parse server responce \(resp)")
                return
            }
            log.info("Socket: orderAccepted, \(json)")
            _ = api.parcer.parseOrder(json.1)
            rxData.checkCurrentOrder()
        })
        // MARK: Waiting for Client
        socket?.on("waitingForClient", callback: { (resp, _) in
            guard let json = JSON(resp).first else {
                log.error("WebSocket can't parse server responce \(resp)")
                return
            }
            log.info("Socket: waitingForClient")
            _ = api.parcer.parseOrder(json.1)
            rxData.checkCurrentOrder()
        })
        
        // MARK: OnWay
        
        socket?.on("onWay", callback: { (resp, _) in
            guard let json = JSON(resp).first else {
                log.error("WebSocket can't parse server responce \(resp)")
                return
            }
            log.info("Socket: onWay")
            log.info(api.parcer.parseOrder(json.1))
            user.info.isNeedToShowOnWayAlert = true
            user.info.isOnWayAlertButtonTapped = false
            rxData.checkCurrentOrder()
        })
        
        socket?.on("orderCancelFromAdmin", callback: { (resp, _) in
            guard let json = JSON(resp).first else {
                log.error("WebSocket can't parse server responce \(resp)")
                return
            }
            if let currentOrder = rxData.currentOrder {
                rxData.state.accept(.current)
            } else {
                log.info("no current order")
            }
        })
        
        socket?.on("addCard", callback: { (resp, _) in
            guard let json = JSON(resp).first else {
                log.error("WebSocket can't parse server responce \(resp)")
                return
            }
            log.info("Socket: addCard")
            log.info(json)
            api.parcer.userData(json.1["User"])
        })
    }
    
}

extension SocketIONetwork {
    
    fileprivate func registration() {
        socket?.emit("registration", ["token": utils.variables.serverToken, "isDriver": user.isDriver])
    }
    
    public func lookForClosestDrivers() {
        socket?.emit("lookForClosestDrivers", ["hashId": user.hashId, "lat": user.location.lat, "lng": user.location.lng])
    }
    
    //    public func chooseCertainDriver(driverId: String) {
    //        socket?.emit("chooseCertainDriver", ["driverId": driverId])
    //    }
    
    public func stopWatchingDriver() {
        socket?.emit("stopWatchingDriver")
        rxData.carOnMap.accept([])
    }
    
    fileprivate func startUpdatingLatLng() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.updateLatLng), userInfo: nil, repeats: true)
    }
    
    fileprivate func stopUpdatingLatLng() {
        timer.invalidate()
    }
    
    @objc fileprivate func updateLatLng() {
        guard isConnected else {
            return
        }
        socket?.emit("newLatLng", ["lat": user.location.lat, "lng": user.location.lng, "hashId": user.hashId, "isDriver": user.isDriver])
        // TODO: Включить когда скажут
    }
    
    /*
     lookForClosestDrivers принимает {clientId: value, latitude: value, longitude: value} и начинает каждые 3 сек эмитить тебе updateNearestDrivers с данными о водилах неподалёку (формат не помню точно данных, по-моему, массив объектов, как в первый эмит)
     chooseCertainDriver принимает {driverId: value} и каждые три секунды эмитит updateCertainDriver с данными об одном водиле
     stopWatchingDriver без данных прекращает все таймеры и слежения
     */
}

extension Double {
    /// Rounds the double to decimal places value
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
