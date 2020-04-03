//
//  ConstantsDevice.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

extension Utiles {
        
    struct Constants {
        public let uuid = UIDevice.current.identifierForVendor!.uuidString
        public var font = Fonts()
        public var colors = Colors()
    }
    
    struct Fonts {
        var bold = "HelveticaNeue-Bold"
        var medium = "HelveticaNeue-Medium"
        var regular = "HelveticaNeue"
    }
    
    struct Colors {
        var darkBlue = UIColor(hexString: "#423A73") ?? UIColor()
        var lightBlue = UIColor(hexString: "#798FE7") ?? UIColor()
        var yellow = UIColor(hexString: "#FFC928") ?? UIColor()
        var red = UIColor(hexString: "#FF0000") ?? UIColor()
        var darkGray = UIColor(hexString: "#555555") ?? UIColor()
        var lightGray = UIColor(hexString: "#7A7A7A") ?? UIColor()
    }
    
    struct APIKeys {
        let googleApiKey = "AIzaSyBPZHeb9JbEXvtlO2HfNFjZigv2hm1X77s"
    }
    
}
