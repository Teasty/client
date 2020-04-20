//
//  MapViewCarOnMap.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 25/06/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension MapView {
    
    public func updateCarOnMap() {
        
        for car in rxData.carOnMap.value {
            if viewModel.carsOnMap.filter({$0.hashId == car.hashId}).isEmpty {
                // add car on map
                viewModel.carsOnMap.append(car)
                let pin = GoogleMapKit.Coordinates(lat: car.lat, lng: car.lng)
                
                var image: UIImage? = UIImage()
                switch car.color {
                case "blue": image = R.image.carBlue()
                case "yellow": image = R.image.cardYellow()
                case "white": image = R.image.carWhite()
                case "red": image = R.image.carRed()
                case "gray": image = UIImage(named: "")
                default: image = R.image.carBlack()
                }
                createMarker(pin, image, car.hashId)
            }
            log.verbose("Car on Map: \(car)")
        }
        
        var toRemove = [CarOnMap]()
        
        for (index, car) in viewModel.carsOnMap.enumerated() {
            if let carFromServer = rxData.carOnMap.value.filter({$0.hashId == car.hashId}).first {
                if let marker = viewModel.markers.filter({$0.userData as? String == car.hashId}).first {

                    let toLat = carFromServer.lat
                    let toLng = carFromServer.lng

                    if rxData.calculateDistance(lat1: car.lat, lon1: car.lng, lat2: toLat, lon2: toLng) > 3.5 {
                        let animationDuration: Float = 3.0
                        CATransaction.begin()
                        CATransaction.setValue(NSNumber(value: animationDuration), forKey: kCATransactionAnimationDuration)
                        marker.position = CLLocationCoordinate2D(latitude: toLat, longitude: toLng)
                        marker.rotation = CLLocationDegrees(exactly: getBearingBetweenTwoPoints1(
                            point1: CLLocation(latitude: car.lat, longitude: car.lng),
                            point2: CLLocation(latitude: toLat, longitude: toLng))) ?? 0.0
                        CATransaction.commit()

                        viewModel.carsOnMap[index].lat = toLat
                        viewModel.carsOnMap[index].lng = toLng

                        log.error("Move: \(viewModel.carsOnMap[index])")
                    }

                    // move var on map
                }
            } else {
                // delete cars from map
                log.verbose("delete")
                for (index, marker) in viewModel.markers.enumerated() {
                    if let type = marker.userData as? String {
                        if type == car.hashId {
                            marker.map = nil
                            viewModel.markers.remove(at: index)
                        }
                    }
                }
            }
        }
        
        viewModel.carsOnMap = rxData.carOnMap.value
        
    }
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
    
    func getBearingBetweenTwoPoints1(point1: CLLocation, point2: CLLocation) -> Double {
        
        let lat1 = degreesToRadians(degrees: point1.coordinate.latitude)
        let lon1 = degreesToRadians(degrees: point1.coordinate.longitude)
        
        let lat2 = degreesToRadians(degrees: point2.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: point2.coordinate.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        return radiansToDegrees(radians: radiansBearing)
    }
    
}
