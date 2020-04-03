//
//  SideMenu.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation
import SideMenu

extension FlowCoordinator {
    
    public func runFlowSideMenu() {
        loadSideMenu()
        stack = createStack()
        guard let root = stack.0.first else {
            log.error("Root Flow for SideMenu is not defined in stack")
            return
        }
        root.start()
    }
    
    fileprivate func loadSideMenu() {
        let view = SideMenuView()
        let sideMenu = SideMenuNavigationController(rootViewController: view)
        sideMenu.isNavigationBarHidden = true
        SideMenuManager.default.menuDismissOnPush = false
        SideMenuManager.default.menuPushStyle = .default
        SideMenuManager.default.menuWidth = 245
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.menuPresentMode = .menuSlideIn
    }
    
    public func setSideMenuButton<T>(_ controller: T?) {
        let button: BaseButton = {
            let button = BaseButton()
            button.setImage(#imageLiteral(resourceName: "sideMenuButton").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
            button.tintColor = UIColor.black
            button.onTap = {
                if let menu = SideMenuManager.default.leftMenuNavigationController {
                    log.verbose(SideMenuManager.default.leftMenuNavigationController)
                    utils.controller()?.present(menu, animated: true, completion: { })
                }
            }
            return button
        }()
        if let controller = controller {
            switch controller {
            case is BaseController:
                if let targetController = controller as? BaseController {
                    button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
                    SideMenuManager.default.menuAddPanGestureToPresent(toView: targetController.navigationController!.navigationBar)
                    SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: targetController.view)
                    targetController.view.addSubview(button)
                    button.snp.makeConstraints { (make) in
                        make.top.equalTo(targetController.view.safeArea.top).offset(13)
                        make.left.equalTo(13)
                        make.height.equalTo(31)
                        make.width.equalTo(36)
                    }
                }
            case is BaseNavigation:
                if let targetController = controller as? BaseNavigation {
                    if let root = targetController.viewControllers.first {
                        SideMenuManager.default.menuAddPanGestureToPresent(toView: root.navigationController!.navigationBar)
                        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: root.view)
                    }
                    targetController.viewControllers.first?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
                }
            default: log.error("Controller type doesnt indentified")
            }
        }
    }
    
}

// MARK: Side Menu

class SideMenuView: BaseController {
    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI()
    }
}

// MARK: private

extension SideMenuView {
    fileprivate func renderUI() {
        bodyTable.renderUI(view)
        bodyTable.bounces = false
        bodyTable.delegate = self
        bodyTable.dataSource = self
        bodyTable.register(SideMenuBaseTableCell.self)
        bodyTable.register(SideMenuTopTableCell.self)
        bodyTable.register(SideMenuExpansionTableCell.self)
        
        // MARK:  if you need to set background to statusBar
        
        let statusBarBackground: BaseImageView = {
            let imageView = BaseImageView()
            imageView.image = R.image.gradientSideMenu()
            return imageView
        }()
        view.addSubview(statusBarBackground)
        statusBarBackground.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(bodyTable.snp.top)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
    }
}

// MARK: Factory

extension SideMenuView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinator.stack.0.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let cell = reuse(tableView, indexPath, "SideMenuTopTableCell") as? SideMenuTopTableCell
            cell?.initialize()
            cell?.buttonClose.onTap = {
                utils.controller()?.dismiss(animated: true, completion: {
                    log.info("Side Menu closed!")
                })
            }
            return cell!
            
        case 1 :
            let cell = reuse(tableView, indexPath, "SideMenuExpansionTableCell") as? SideMenuExpansionTableCell
            cell?.initialize(coordinator.stack.1[indexPath.row].title)
            cell?.onTap = {
                router.transition(.present, coordinator.stack.0[indexPath.row].navigation)
            }
            return cell!
            
        case 5:
            let cell = reuse(tableView, indexPath, "SideMenuBaseTableCell") as? SideMenuBaseTableCell
            cell?.initialize("Звонок диспетчеру")
            cell?.onTap = {
                utils.makePhoneCall(number: "+78182280000")
            }
            return cell!
            
        case 6:
            let cell = reuse(tableView, indexPath, "SideMenuBaseTableCell") as? SideMenuBaseTableCell
            cell?.initialize("Поделиться ссылкой на приложение")
            cell?.onTap = {
                utils.socialShare(message: "Самое выгодное такси в Архангельске", link: "https://www.google.com")
            }
            return cell!
            
        case 7:
            let cell = reuse(tableView, indexPath, "SideMenuBaseTableCell") as? SideMenuBaseTableCell
            cell?.initialize(coordinator.stack.1[indexPath.row - 2].title)
            cell?.onTap = {
                router.transition(.present, coordinator.stack.0[indexPath.row - 2].navigation)
            }
            return cell!
            
        default:
            let cell = reuse(tableView, indexPath, "SideMenuBaseTableCell") as? SideMenuBaseTableCell
            cell?.initialize(coordinator.stack.1[indexPath.row].title)
            cell?.onTap = {
                router.transition(.present, coordinator.stack.0[indexPath.row].navigation)
            }
            return cell!
        }
    }
    
}
