//
//  AutocompliteGM.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 03/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AutocompliteGM: GMSAutocompleteViewController {

    public var onSelect: ((GoogleMapKit.Address) -> Void)?
    fileprivate var address = GoogleMapKit.Address()

    public func open(_ filerType: GMSPlacesAutocompleteTypeFilter) {

        primaryTextHighlightColor = UIColor.black
        primaryTextColor = UIColor(hexString: "#7A7A7A") ?? UIColor()

        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.black], for: .normal)

        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue:
            UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.addressComponents.rawValue) |
            UInt(GMSPlaceField.coordinate.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue))!
        placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
//        filter.type = filerType
        filter.country = "RU"
        autocompleteFilter = filter
        
        autocompleteBounds = GMSCoordinateBounds(
            coordinate: CLLocationCoordinate2D(latitude: user.location.lat + 0.4, longitude: user.location.lng + 0.4),
            coordinate: CLLocationCoordinate2D(latitude: user.location.lat - 0.4, longitude: user.location.lng - 0.4)
        )

        // Display the autocomplete view controller.
        delegate = self
        utils.controller()?.present(self, animated: true, completion: nil)
    }

    deinit {
        log.debug("deinit Controller: \(self.className)")
    }

}

extension AutocompliteGM: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
//        log.verbose(place.attributions)
//        log.verbose(place.name)
//        log.verbose(place.openingHours)
//        log.verbose(place.phoneNumber)
//        log.verbose(place.photos)
//        log.verbose(place.placeID)
//        log.verbose(place.plusCode)
//        log.verbose(place.rating)
//        log.verbose(place.types)

        
        
        if let components = place.addressComponents {
            var address = utils.googleMapKit.parseGoogleMapResultsFromComponents(components)
            address.lat = place.coordinate.latitude
            address.lng = place.coordinate.longitude
            address.isPlace = place.placeID?.count ?? 0 < 40 ? true : false
            address.stringName = place.name ?? ""
            self.address = address
//            onSelect?(address)
        } else {
            log.error("Error in getting Address Compoments")
        }
        dismiss(animated: true) { [unowned self] in
            self.onSelect?(self.address)
        }
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        log.error(error.localizedDescription)
    }

    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }

    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}
