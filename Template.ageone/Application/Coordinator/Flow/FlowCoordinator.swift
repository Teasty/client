//
//  FlowCoordinator.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import PromiseKit

private enum LaunchInstructor {
    case main, auth
    static func configure( isAutorized: Bool = user.isAutorized && !user.phone.isEmpty) -> LaunchInstructor {
        switch !isAutorized {
        case true: return .auth     // auth
        case false: return .main
        }
    }
}

class FlowCoordinator: Coordinator {
    public var stack: ([BaseFlow], [UITabBarItem]) = ([], [])
    private var instructor: LaunchInstructor {
        return LaunchInstructor.configure()
    }
}

// MARK: Flows

extension FlowCoordinator {
    
    // MARK: Start Flow
    
    public func start() {
        switch self.instructor {
        case .auth: self.runFlowAuth()
        case .main: self.runFlowLoading()
        }
    }
    
    public func setLaunchScreen() {
        router.transition(Router.Transition.replace, LaunchViewController())
    }

    // MARK: Restricted Core Flow [Don't use as template]
    
    fileprivate func runFlowLoading() {
        api.requestMainLoad()
        socket._init()
        var flow: FlowLoading? = FlowLoading()
        flow?.onFinishFlow = { [unowned self] in
            self.runFlowSideMenu()
            flow = nil
        }
        flow?.start()
    }

    // MARK: auth
    
    public func runFlowAuth() {
        var flow: FlowAuth? = FlowAuth()
        flow?.onFinishFlow = { [unowned self] in
            self.start()
            flow = nil
        }
        flow?.start()
    }
    
    // MARK: Custom Flow [snippet - flow]
    
    // MARK: WishList
    
    public func runFlowWishList() {
        var flow: FlowWishList? = FlowWishList()
        flow?.onFinishFlow = { flow = nil }
        flow?.start()
    }
    
    // MARK: FlowAccurancy
    
    public func runFlowAccurancy() {
        var flow: FlowAccurancy? = FlowAccurancy()
        flow?.onFinishFlow = { flow = nil }
        flow?.start()
    }
    
    // MARK: FlowChangeAuth
    
    public func runFlowChangeAuth() {
        var flow: FlowChangeAuth? = FlowChangeAuth()
        flow?.onFinishFlow = { flow = nil }
        flow?.start()
    }
}
