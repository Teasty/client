//
//  UIApplicationExtenstions.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topController(
        base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topController(base: presented)
        }
        return base
    }
}
