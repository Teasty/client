//
//  DataBase.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 21/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Alamofire
import SwiftyJSON

// MARK: base methods

extension DataBase {
    
    public func update(_ objectID: String, _ objectStruct: [String: Any]) {
        let parameters: Parameters = [
            "router": "update",
            "collectionName": self.getObject(),
            "elementId": objectID,
            "jsonValues": objectStruct
        ]
        let dubug = Alamofire.request(
            "\(DataBase.url)\(DataBase.database)",
            method: HTTPMethod.post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: DataBase.headers).responseJSON { responce in
                let json = JSON(responce.result.value!)
                if json["error"].exists() {
                    log.error(json["error"].stringValue)
                }
        }
        debugPrint(dubug)
    }
    
    public func delete(_ objectID: String) {
        let parameters: Parameters = [
            "router": "delete",
            "collectionName": self.getObject(),
            "elementId": objectID
        ]
        let debug = Alamofire.request(
            "\(DataBase.url)\(DataBase.database)",
            method: HTTPMethod.post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: DataBase.headers).responseJSON { responce in
                let json = JSON(responce.result.value!)
                if json["error"].exists() {
                    log.error(json["error"].stringValue)
                }
        }
        debugPrint(debug)
    }
    
    public func fetch(completion: @escaping (_ query: String) -> Void) {
        let parameters: Parameters = [
            "method": "update",
            "query": self.getObject()
        ]
        Alamofire.request(
            "\(DataBase.url)\(DataBase.database)",
            method: HTTPMethod.post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: DataBase.headers).responseJSON { responce in
                let json = JSON(responce.result.value!)
                if json["error"].exists() {
                    log.error(json["error"].stringValue)
                }
        }
    }
    
}
