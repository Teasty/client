//
//  BaseFlow.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 14/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import Foundation

class BaseFlow: FlowProtocol {

    // MARK: actions
    
    public var onStartFlow: (() -> Void)?
    public var onFinishFlow: (() -> Void)?
    
    // MARK: init deinit

    init() {
        log.debug("init Flow: \(self)")
    }
    
    init(root: BaseController) {
        rootController = root
    }
    
    deinit {
        onStartFlow = nil
        onFinishFlow = nil
        log.debug("deinit Flow: \(self)")
    }
    
    // MARK: var
    
    lazy var rootController = BaseController()
    lazy var navigation = UINavigationController()
    
    // MARK: public
    
    public func start() {
        onStartFlow?()
    }
    
    public func finish() {
        onFinishFlow?()
        rootController.clearResource(true)
        onStartFlow = nil
        onFinishFlow = nil
    }
    
    public func eventError(_ event: String) {
        log.error("event \(event) is not defined in case handle of the flow \(self)")
    }
    
    public func setRootController(_ controller: BaseController) {
        rootController = controller
        rootController.isRootController = true
    }
    
    public func setNavigationController() {
        navigation = BaseNavigation(rootViewController: rootController)
    }
    
}
