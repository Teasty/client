//
//  UserLocation.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation

extension UserData {
    
    struct Location {
        
        public var lat: Double {
            get {
                return UserDefaults.standard.double(forKey: "user_location_lat")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_location_lat")
            }
        }
        
        public var lng: Double {
            get {
                return UserDefaults.standard.double(forKey: "user_location_lng")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_location_lng")
            }
        }
        
    }
    
}
