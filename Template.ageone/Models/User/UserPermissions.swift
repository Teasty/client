//
//  UserPermissions.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation

extension UserData {
    
    struct Permission {
        
        public var geo: Bool {
            get {
                return UserDefaults.standard.bool(forKey: "user_permission_geo")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_permission_geo")
            }
        }
        
        public var push: Bool {
            get {
                return UserDefaults.standard.bool(forKey: "user_permission_push")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_permission_push")
            }
        }
        
    }
    
}
