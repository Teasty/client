//
//  LocationManager.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    fileprivate var isSingleDetection = Bool()
    public enum RequestType {
        case inUse
        case always
    }
    
    public var onLocationDetected: (() -> Void)!
    
    fileprivate var locationManager = CLLocationManager()
    fileprivate var isLocationDetected = Bool()
    
    public func requestUserLocation(_ requestType: RequestType, singleDetection: Bool = false) {
        isSingleDetection = singleDetection
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        switch requestType {
        case .inUse:
            locationManager.requestWhenInUseAuthorization()
        case .always:
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            user.location.lat = userLocation.coordinate.latitude
            user.location.lng = userLocation.coordinate.longitude
            if !isLocationDetected {
                log.warning("CLLocationManager Location Detected, Permission success")
                isLocationDetected = true
                if let callback = onLocationDetected {
                    callback()
                }
            }
            if isLocationDetected && isSingleDetection {
                locationManager.stopMonitoringSignificantLocationChanges()
                locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        log.warning("CLLocationManager Location Detected, Permission denied")
        user.location.lat = 64.554750
        user.location.lng = 40.562800
        if let callback = onLocationDetected {
            callback()
        }
    }
    
}
