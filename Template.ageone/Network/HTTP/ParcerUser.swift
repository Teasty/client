//
//  ParcerUser.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 19/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import SwiftyJSON
import RealmSwift

extension Parser {
    public func userData(_  json: JSON) {
        
        user.hashId = json["hashId"].stringValue
        user.email = json["email"].stringValue
        user.phone = json["phone"].stringValue
        
        for card in json["cards"] {
            let realm = try! Realm()
            try! realm.write {
                let payment = Payment()
                payment.lastCardDigits = card.1["lastCardDigits"].stringValue
                payment.hashId = json["hashId"].stringValue
                payment.isExist = json["isExist"].boolValue
                realm.add(payment, update: true)
            }
        }
        
        log.verbose("user logged in: \(user.hashId)")
//        log.verbose(json)
    }
}
