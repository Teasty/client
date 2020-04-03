//
//  FCMService.swift
//  Template.ageone
//
//  Created by Андрей Лихачев on 05.02.2020.
//  Copyright © 2020 Konstantin Kovalenko. All rights reserved.
//

import SocketIO
import SwiftyJSON
import RealmSwift
import PromiseKit

import RxCocoa
import RxSwift
import RxRealm

class FCM {
    
    public let parcer = Parser()
    
    public enum Actions {
        static var updateNearestDrivers = "updateNearestDrivers"
        static var updateCertainDriver = "updateCertainDriver"
        static var orderAccepted = "orderAccepted"
        static var timeDriverArrived = "timeDriverArrived"
        static var arrived = "arrived"
        static var onWay = "onWay"
    }
}
