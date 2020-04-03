//
//  Model.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

//import ObjectMapper
//import RealmSwift
//import ObjectMapper_Realm
//
//// MARK: about
//// Convert a JSON string to a model object: let user = User(JSONString: JSONString)
//// Convert a model object to a JSON string: let JSONString = user.toJSONString(prettyPrint: true)
//
//// MARK: User
//
///*
//class User: Object, Mappable {
// 
//    @objc dynamic var username: NSString?
//    var friends: List<User>?
// 
//    required convenience init?(map: Map) {
//        self.init()
//    }
// 
//    override class func primaryKey() -> String? {
//        return "username"
//    }
// 
//    func mapping(map: Map) {
//        username              <- map["username"]
//        friends               <- (map["friends"], ListTransform<User>())
//    }
// 
//}
//*/
//
//class RealmImage: Object, Mappable {
//
//    @objc dynamic var hashId = String()
//    @objc dynamic var original = String()
//    @objc dynamic var preview = String()
//    
//    required convenience init?(map: Map) {
//        self.init()
//    }
//    
//    override class func primaryKey() -> String? {
//        return "hashId"
//    }
//    
//    func mapping(map: Map) {
//        hashId                  <- map["__id"]
//        original                <- map["original"]
//        preview                 <- map["preview"]
//    }
//
//}
