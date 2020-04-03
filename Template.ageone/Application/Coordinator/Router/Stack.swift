//
//  Stack.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

extension FlowCoordinator {
    
    public func createStack() -> ([BaseFlow], [UITabBarItem]) {
        
        var flowMap: FlowMap? = FlowMap()
        flowMap?.onFinishFlow = { flowMap = nil }
        flowMap?.start()
        
        var flowCards: FlowCards? = FlowCards()
        flowCards?.onFinishFlow = { flowCards = nil }
        flowCards?.start()
        
        var flowFavorite: FlowFavorite? = FlowFavorite()
        flowFavorite?.onFinishFlow = { flowFavorite = nil }
        flowFavorite?.start()
        
        var flowHistory: FlowHistory? = FlowHistory()
        flowHistory?.onFinishFlow = { flowHistory = nil }
        flowHistory?.start()
        
        var flowLostes: FlowLostes? = FlowLostes()
        flowLostes?.onFinishFlow = { flowLostes = nil }
        flowLostes?.start()
        
        var flowArticles: FlowArticles? = FlowArticles()
        flowArticles?.onFinishFlow = { flowArticles = nil }
        flowArticles?.start()
        
        let flows: [BaseFlow] = [
            flowMap!,
            flowCards!,
            flowFavorite!,
            flowHistory!,
            flowLostes!,
            flowArticles!
        ]
        
        let items: [UITabBarItem] = [
            UITabBarItem(
                title: "Карта",
                image: R.image.tabBarSelectionUnSelect(),
                selectedImage: R.image.tabBarSelectionSelect()
            ),
            UITabBarItem(
                title: "Способ оплаты",
                image: R.image.tabBarSelectionUnSelect(),
                selectedImage: R.image.tabBarSelectionSelect()
            ),
            UITabBarItem(
                title: "Любимые адреса",
                image: R.image.tabBarSelectionUnSelect(),
                selectedImage: R.image.tabBarSelectionSelect()
            ),
            UITabBarItem(
                title: "История поездок",
                image: R.image.tabBarSelectionUnSelect(),
                selectedImage: R.image.tabBarSelectionSelect()
            ),
            UITabBarItem(
                title: "Забытые вещи",
                image: R.image.tabBarSelectionUnSelect(),
                selectedImage: R.image.tabBarSelectionSelect()
            ),
            UITabBarItem(
                title: "О приложении",
                image: R.image.tabBarSelectionUnSelect(),
                selectedImage: R.image.tabBarSelectionSelect()
            )
        ]
        return (flows, items)
        
    }
    
}
