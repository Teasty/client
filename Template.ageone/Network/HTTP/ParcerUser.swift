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
        
        let activecard = json["activeCard"]
        if activecard["hashId"].exists() {
            user.info.paymentType = activecard["hashId"].stringValue
        } else {
            user.info.paymentType = "cash"
        }
        
        for card in json["cardList"] {
            let realm = try! Realm()
            try! realm.write {
                let payment = Card()
                log.info(card)
                payment.created = card.1["created"].intValue
                payment.updated = card.1["updated"].intValue
                payment.hashId = card.1["hashId"].stringValue
                payment.isExist = card.1["isExist"].boolValue
                payment.cardHolder = card.1["cardHolder"].stringValue
                payment.cardNumber = card.1["cardNumber"].stringValue
                realm.add(payment, update: true)
            }
        }
        
        log.verbose("user logged in: \(user.hashId)")
//        log.verbose(json)
    }
}
