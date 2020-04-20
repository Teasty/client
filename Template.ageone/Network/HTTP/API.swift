//
//  API.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 14/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import SwiftyJSON
import Alamofire
import PromiseKit
import RealmSwift

class API {
    
    public let parcer = Parser()
    
    public enum Routes {
        static var handshake = "/handshake"
        static var api = "/api"
    }
    
    public func handshake() -> Promise<Void> {
        return Promise { seal in
            let parameters: Parameters = [
                "deviceId": utils.constants.uuid,
                "isDriver": "false"
            ]
            log.info("Параметры: \(parameters)")
            Alamofire.request(
                "\(DataBase.url)\(Routes.handshake)",
                method: HTTPMethod.post,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: DataBase.headers)
                .responseJSON { responce in
                    guard let value = responce.result.value else {
                        if let error = responce.error {
                            log.error(responce)
                            //                            MARK:  Кинуть АЛЕРТ
                        }
                        return
                    }
                    
                    let json = JSON(value)
                    if json["error"].exists() {
                        log.error(json["error"].stringValue)
                        //                        MARK:  Кинуть АЛЕРТ
                        return
                    } else {
                        utils.variables.serverToken = json["Token"].stringValue
                        database.headers["x-access-token"] = utils.variables.serverToken
                        self.parcer.userData(json["User"])
                        log.info("\(json["serverVersion"].intValue) == \(user.serverVersion)")
                        if json["serverVersion"].intValue != user.serverVersion {
                            user.isAutorized = false
                            let realm = try! Realm()
                            try! realm.write {
                                realm.deleteAll()
                            }
                            user.info.cacheTime = 0
                            user.serverVersion = json["serverVersion"].intValue
                        }
                        seal.fulfill_()
                    }
            }
        }
    }
    
    public func request(
        _ parameters: Parameters,
        _ isErrorShow: Bool = false,
        completion: @escaping (JSON) -> Void) {
        let debug = Alamofire.request(
            "\(DataBase.url)\(Routes.api)",
            method: HTTPMethod.post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: DataBase.headers).responseJSON { responce in
                
//                log.error(responce.debugDescription)
                
                guard let statusCode = responce.response?.statusCode else { return }
                
                guard let value = responce.result.value else {
                    if let error = responce.error {
                        alertAction.message(error.localizedDescription)
                        log.error(error.localizedDescription)
                        loading.hide()
                    }
                    return
                }
                
                let json = JSON(value)
                if json["error"].exists() && !(200..<300).contains(statusCode) {
                    log.error(json["error"].stringValue)
                    if isErrorShow {
                        loading.hide()
                        alertAction.message(json["error"].stringValue)
                    } else {
                        completion(json)
                    }
                } else {
                    completion(json)
                }
        }
        debugPrint(debug)
    }
}
