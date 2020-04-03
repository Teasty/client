//
//  GoogleMapKit.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 04/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Alamofire
import SwiftyJSON
import GoogleMaps
import GooglePlaces

class GoogleMapKit {
    
    struct Address {
        var home = String()
        var postalCode = String()
        var street = String()
        var region = String()
        var city = String()
        var country = String()
        var isPlace = Bool()
        var lat = Double()
        var lng = Double()
        var stringName = String()
    }
    
    struct Coordinates {
        var lat = Double()
        var lng = Double()
    }
    
    enum ComponentType: String, CaseIterable {
        case home, postalCode, street, region, city, country, none
    }
    
    public func autocomplite(_ filerType: GMSPlacesAutocompleteTypeFilter = GMSPlacesAutocompleteTypeFilter.establishment, completion: @escaping (Address) -> Void) {
        var autocompliteGM: AutocompliteGM? = AutocompliteGM()
        autocompliteGM?.onSelect = { address in
            autocompliteGM = nil
            completion(address)
        }
        autocompliteGM?.open(filerType)
    }
 
    func getAddressFromLatLong(address: String, completion: @escaping (Address) -> Void) {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?address=\(address))&key=\(utils.keys.googleApiKey)"
        log.info(url)
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        Alamofire.request(encodedUrl).validate().responseJSON { response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                log.info(self.parseGoogleMapResultsFromJson(json))
                completion(self.parseGoogleMapResultsFromJson(json))
            case .failure(let error):
                log.error(error)
            }
        }
    }
    
    public func parseGoogleMapResultsFromJson(_ json: JSON) -> Address {
        var address = Address()
        address.lat = json["results"][0]["geometry"]["location"]["lat"].doubleValue
        address.lng = json["results"][0]["geometry"]["location"]["lng"].doubleValue
        for item in json["results"][0]["address_components"] {
            let type = item.1["types"][0].stringValue
            let value = item.1["short_name"].stringValue.isEmpty ? item.1["long_name"].stringValue : item.1["short_name"].stringValue
            switch getAddressComponentByType(type) {
            case .home: address.home = value
            case .postalCode: address.postalCode = value
            case .street: address.street = value
            case .region: address.region = value
            case .city: address.city = value
            case .country: address.country = value
            case .none: log.error("Cant parce \(type) from Google Map Address Component")
            }
        }
        return address
    }
    
    public func parseGoogleMapResultsFromComponents(_ components: [GMSAddressComponent]) -> Address {
        var address = Address()
        for component in components {
            let type = component.type
            if let value = component.shortName?.isEmpty ?? false ? component.name : component.shortName {
                switch getAddressComponentByType(type) {
                case .home: address.home = value
                case .postalCode: address.postalCode = value
                case .street: address.street = value
                case .region: address.region = value
                case .city: address.city = value
                case .country: address.country = value
                case .none: log.error("Cant parce \(type) from Google Map Address Component")
                }
            }
        }
        return address
    }
    
    public func geodecodeByCoordinatesByAPI(_ coordinates: Coordinates, completion: @escaping (Address) -> Void) {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(coordinates.lat),\(coordinates.lng)&key=\(utils.keys.googleApiKey)"
        log.info(url)
        Alamofire.request(url).validate().responseJSON { [unowned self] response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                log.info(self.parseGoogleMapResultsFromJson(json))
                completion(self.parseGoogleMapResultsFromJson(json))
            case .failure(let error):
                log.error(error)
            }
        }
    }
    
    public func geodecodeByCoordinatesOnDevice(_ coordinates: Coordinates, completion: @escaping (Address) -> Void) {
        let geocoder = GMSGeocoder()
        if let lat = CLLocationDegrees(exactly: coordinates.lat), let lng = CLLocationDegrees(exactly: coordinates.lng) {
            geocoder.reverseGeocodeCoordinate(CLLocationCoordinate2D(latitude: lat, longitude: lng)) { (response, error) in
                if let error = error {
                    log.error(error)
                    return
                }
                if let address = response?.firstResult() {
                    log.verbose(address)
                }
            }
        }
    }
    
//    public func geodecodeByAddress(_ address: String){
//        let url = "https://maps.googleapis.com/maps/api/geocode/json?address=\(address)&key=\(utils.keys.googleApiKey)"
//        Alamofire.request(url).validate().responseJSON { [unowned self] response in
//            switch response.result {
//            case .success:
//                let json = JSON(response.result.value!)
//                log.verbose(json)
//                completion(self.parseGoogleMapResultsFromJson(json))
//            case .failure(let error):
//                log.error(error)
//            }
//        }
//    }
    
}

extension GoogleMapKit {
    
    fileprivate func getAddressComponentByType(_ type: String) -> ComponentType {
        if ["street_number"].contains(type) { return ComponentType.home }
        if ["postal_code"].contains(type) { return ComponentType.postalCode }
        if ["street_address", "route"].contains(type) { return ComponentType.street }
        if ["administrative_area_level_1",
            "administrative_area_level_2",
            "administrative_area_level_3",
            "administrative_area_level_4",
            "administrative_area_level_5"].contains(type) { return ComponentType.region }
        if ["locality",
            "sublocality",
            "sublocality_level_1",
            "sublocality_level_2",
            "sublocality_level_3",
            "sublocality_level_4"].contains(type) { return ComponentType.city }
        if ["country"].contains(type) { return ComponentType.country }
        return ComponentType.none
    }
    
}

// MARK: Request Route

extension GoogleMapKit {
    
    public func loadRoutePath(from: Coordinates, to: Coordinates, waypoints: [Coordinates], completion: @escaping ([GMSPath]) -> Void) {
        let origin = "\(from.lat),\(from.lng)"
        let destination = "\(to.lat),\(to.lng)"
        var waypointsRoute = String()
        if !waypoints.isEmpty {
            waypointsRoute = "&waypoints="
            for waypoint in waypoints {
                waypointsRoute += "via:\(waypoint.lat),\(waypoint.lng)%7C"
            }
            waypointsRoute = String(waypointsRoute.dropLast(3))
        }
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)\(waypointsRoute)&mode=driving&key=\(utils.keys.googleApiKey)"
        log.info(url)
        Alamofire.request(url).validate().responseJSON { response in
            let json = JSON(response.result.value!)
            let routes = json["routes"].arrayValue
            var responce = [GMSPath]()
            for route in routes {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                if let points = routeOverviewPolyline?["points"]?.stringValue {
                    if let path = GMSPath.init(fromEncodedPath: points) {
                        responce.append(path)
                    }
                }
            }
            completion(responce)
        }
    }
    
//    public func loadRoutePath2(from: Coordinates, to: Coordinates) -> [GMSPath] {
//        let origin = "\(from.lat),\(from.lng)"
//        let destination = "\(to.lat),\(to.lng)"
//        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(utils.keys.googleApiKey)"
//        Alamofire.request(url).validate().responseJSON { response in
//            let json = JSON(response.result.value!)
//            let routes = json["routes"].arrayValue
//            let responce = [GMSPath]()
//            for route in routes {
//                let routeOverviewPolyline = route["overview_polyline"].dictionary
//                let points = routeOverviewPolyline?["points"]?.stringValue
//                let path = GMSPath.init(fromEncodedPath: points!)
//                let polyline = GMSPolyline.init(path: path)
//                polyline.strokeColor = UIColor.blue
//                polyline.strokeWidth = 2
//                polyline.map = map
//                map.animate(with: GMSCameraUpdate.fit(GMSCoordinateBounds(path: path!), withPadding: 50.0))
//            }
//        }
//    }
    
}
