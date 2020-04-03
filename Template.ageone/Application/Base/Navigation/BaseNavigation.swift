//
//  BaseNavigation.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class BaseNavigation: UINavigationController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureUI()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    fileprivate func configureUI() {
        navigationBar.barTintColor = UIColor.white
        navigationBar.isTranslucent = false

        // MARK: change back button color

        navigationBar.tintColor = UIColor.black
        
        // MARK: remove back button text

        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.clear], for: .highlighted)
    }
    
}
