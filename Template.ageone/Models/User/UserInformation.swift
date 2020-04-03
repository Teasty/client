//
//  UserInformation.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation

extension UserData {
    
    struct Information {
        
        public var paymentType: String {
            get {
                return UserDefaults.standard.string(forKey: "user_paymentType") ?? ""
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_paymentType")
            }
        }
        
        public var didAskForDiscount: Bool {
            get {
                return UserDefaults.standard.bool(forKey: "didAskForDiscount") ?? false
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "didAskForDiscount")
            }
        }
        
        public var cacheTime: Int {
            get {
                return UserDefaults.standard.integer(forKey: "api_cashTime")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "api_cashTime")
            }
        }
        
        public var startTimerTime: Int {
            get {
                return UserDefaults.standard.integer(forKey: "user_startTimerTime")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_startTimerTime")
            }
        }
        
        public var isNeedToShowOnWayAlert: Bool {
            get {
                return UserDefaults.standard.bool(forKey: "user_isNeedToShowOnWayAlert")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_isNeedToShowOnWayAlert")
            }
        }
        
        public var isOnWayAlertButtonTapped: Bool {
            get {
                return UserDefaults.standard.bool(forKey: "user_isOnWayAlertButtonTapped")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_isOnWayAlertButtonTapped")
            }
        }
        
        public var onWayAlertLastHashId: String? {
            get {
                return UserDefaults.standard.string(forKey: "user_onWayAlertLastHashId")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_onWayAlertLastHashId")
            }
        }
        
        public var isNeedToShowRateOrderView: Bool {
            get {
                return UserDefaults.standard.bool(forKey: "user_isNeedToShowRateOrderAlert")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_isNeedToShowRateOrderAlert")
            }
        }
        
        public var rateOrderViewButtonIsTapped: Bool {
            get {
                return UserDefaults.standard.bool(forKey: "user_rateOrderViewButtonIsTapped")
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "user_rateOrderViewButtonIsTapped")
            }
        }
        
    }
    
}
