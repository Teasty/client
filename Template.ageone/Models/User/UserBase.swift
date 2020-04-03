//
//  UserBase.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation

class UserData {
    
    var info = Information()
    var permission = Permission()
    var location = Location()
    
    public var serverVersion: Int {
        get {
            return UserDefaults.standard.integer(forKey: "serverVersion") 
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "serverVersion")
        }
    }
    
    public var hashId: String {
        get {
            return UserDefaults.standard.string(forKey: "user_hash") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user_hash")
        }
    }
    
    public var tokenFCM: String {
        get {
            return UserDefaults.standard.string(forKey: "user_tokenFCM") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user_tokenFCM")
        }
    }
    
    public var phone: String {
        get {
            return UserDefaults.standard.string(forKey: "user_phone") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user_phone")
        }
    }
    
    public var email: String {
        get {
            return UserDefaults.standard.string(forKey: "user_email") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user_email")
        }
    }
    
    public var isAutorized: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "user_isAutorized")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user_isAutorized")
        }
    }
    public var isDriver: Bool {
        get {
            return false
        }
    }
}
