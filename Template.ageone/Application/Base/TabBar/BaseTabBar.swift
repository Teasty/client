//
//  CETabBarController.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class BaseTabBar: UITabBarController {
    
    // MARK: var

    private var flows = [BaseFlow]()
    private var items = [UITabBarItem]()
    
    // MARK: actions
    
    public var isTabSelected: ((Int) -> Void)?
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureUI()
    }
    
    // MARK: public
    
    public func appendTabs(receivedFlows: [BaseFlow], receivedItems: [UITabBarItem]) {
        flows = receivedFlows
        items = receivedItems
        setUpTabs()
    }
    
}

// MARK: setUpTabs

extension BaseTabBar {
    
    fileprivate func setUpTabs() {
        var array = [BaseNavigation]()
        if flows.count == items.count {
            for index in 0...items.count - 1 {
                flows[index].start()
                let tab = BaseNavigation(rootViewController: flows[index].rootController)
                tab.tabBarItem = items[index]
                array.append(tab)
            }
        }
        setViewControllers(array, animated: false)
        selectedIndex = 0
    }
    
    // MARK: large icons
    
    fileprivate func setLargeTabsIcons() {
        tabBarItem.imageInsets = UIEdgeInsets.init(top: 6, left: 0, bottom: -6, right: 0)
        for item in viewControllers! {
            item.tabBarItem.imageInsets = UIEdgeInsets.init(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
}

// MARK: delegate

extension BaseTabBar: UITabBarControllerDelegate {
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController) -> Bool {
        
        switch viewController.children[0].className {
            
        case "settings_vc": return false
            
        default: return true
        }
        
    }
    
}

// MARK: Configure

extension BaseTabBar {
    
    fileprivate func configureUI() {
        tabBar.tintColor = UIColor.black
        tabBar.barTintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.black
        tabBar.isTranslucent = false
    }
    
}
