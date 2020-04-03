//
//  FlowMethods.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

// MARK: system methods

final class Router {
    
    // MARK: root window
    
    public var window: UIWindow?
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    // MARK: transition types
    
    public enum Transition {
        case push
        case present
        case replace
    }
    
    // MARK: public
    
    public func transition<T>(_ transition: Transition, _ controller: T?) {
        if let controller = controller {
            switch controller {
            case is BaseController:
                if let controller = controller as? BaseController {
                    openController(transition, controller)
                }
            case is BaseNavigation:
                if let controller = controller as? BaseNavigation {
                    openNavigation(transition, controller)
                }
            case is BaseTabBar:
                if let controller = controller as? BaseTabBar {
                    openTabbar(transition, controller)
                }
            default: log.error("Fatal Error: controller type doesnt indentified")
            }
        }
    }
    
    fileprivate func openController<T: BaseController>(_ transition: Transition, _ controller: T) {
        switch transition {
        case .push: push(controller)
        case .present: present(controller)
        case .replace: replace(controller)
        }
    }
        
    fileprivate func openNavigation<T: BaseNavigation>(_ transition: Transition, _ controller: T) {
        switch transition {
        case .present: present(controller)
        case .replace: replace(controller)
        default: log.error("Fatal Error: transition \(transition) doesnt support for \(controller.className)")
        }
    }
    
    fileprivate func openTabbar<T: BaseTabBar>(_ transition: Transition, _ controller: T) {
        switch transition {
        case .present: present(controller)
        case .replace: replace(controller)
        default: log.error("Fatal Error: transition \(transition) doesnt support for \(controller.className)")
        }
    }
    
}

// MARK: methods

extension Router {
    
    fileprivate func push<T>(_ controller: T) {
        DispatchQueue.main.async {
            if let targetController = controller as? BaseController {
                utils.navigation()?.pushViewController(targetController, animated: true)
            }
        }
    }
    
    fileprivate func present<T: BaseController>(_ controller: T) {
        DispatchQueue.main.async {
            utils.controller()?.present(controller, animated: true, completion: nil)
        }
    }
    
    fileprivate func present<T: BaseNavigation>(_ navigation: T) {
        DispatchQueue.main.async {
            utils.controller()?.present(navigation, animated: true, completion: nil)
        }
    }
    
    fileprivate func present<T: BaseTabBar>(_ tabbar: T) {
        DispatchQueue.main.async {
            utils.controller()?.present(tabbar, animated: true, completion: nil)
        }
    }
    
    fileprivate func replace<T: BaseController>(_ controller: T) {
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
    
    fileprivate func replace<T: BaseNavigation>(_ navigation: T) {
        guard let window = self.window else {
            log.error("Fatal error on window unwarp")
            return
        }
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    fileprivate func replace<T: BaseTabBar>(_ tabbar: T) {
        guard let window = self.window else {
            log.error("Fatal error on window unwarp")
            return
        }
        window.rootViewController = tabbar
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
}

extension Router {
    
    public func popToRoot(_ animated: Bool = true) {
        utils.navigation()?.popToRootViewController(animated: animated)
    }
    
}
