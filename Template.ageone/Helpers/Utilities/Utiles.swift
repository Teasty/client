//
//  Constants.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
import RealmSwift

class Utiles {

    // MARK: Constants / Variables

    public var constants = Constants()
    public var variables = Variables()
    public var validation = Validation()
    public var formatter = Formatter()
    public var realm = RealmUtilles()
    public var image = Images()
    public var keys = APIKeys()
    
    
    public var googleMapKit = GoogleMapKit()
    
    init() {
        let config = Realm.Configuration(
        schemaVersion: 7,
        deleteRealmIfMigrationNeeded: true
        )

        Realm.Configuration.defaultConfiguration = config
    }
    
    
    // MARK: current navigation and current controller

    public func controller() -> UIViewController? {
        if let controller = UIApplication.topController() {
            return controller
        }
        return nil
    }
    
    public func navigation() -> UINavigationController? {
        if let navigation = UIApplication.topController()?.navigationController {
            return navigation
        }
        return nil
    }
    
    public func tabbar() -> UITabBarController? {
        if let tabbar = UIApplication.topController()?.tabBarController {
            return tabbar
        }
        return nil
    }
    
}

extension Utiles {
    
    public func displayFonts() {
        for famaly: String in UIFont.familyNames {
            print("\(famaly)")
            for names: String in UIFont.fontNames(forFamilyName: famaly) {
                print("== \(names)")
            }
        }
    }
    
    public func makePhoneCall(number: String) {
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            log.error("Phone number \(number) is wrong")
        }
    }
    
    public func socialShare(message: String, link: String) {
        if let link = NSURL(string: link) {
            let objectsToShare = [message,link] as [Any]
            let share = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            utils.controller()?.present(share, animated: true, completion: { })
        }
    }
    
    public func geodecode(_ address: String, completion: @escaping (Bool, Double, Double) -> ()) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                completion(false, 0, 0)
                return
            }
            if let coordinats = placemarks?.first?.location?.coordinate {
                completion(true, Double(coordinats.latitude), Double(coordinats.longitude))
            } else {
                completion(false, 0, 0)
            }
        }
    }
    
}
