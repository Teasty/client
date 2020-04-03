//
//  TabBar.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

extension FlowCoordinator {

    public func runFlowTabbar() {
        stack = createStack()
        let tabbar = BaseTabBar()
        tabbar.appendTabs(receivedFlows: stack.0, receivedItems: stack.1)
        router.transition(.replace, tabbar)
    }

}
