//
//  BaseController.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 12/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import RealmSwift
import PromiseKit

class BaseController: UIViewController {
    
    // MARK: - disposeBag
    
    public let disposeBag = DisposeBag()
    
    // MARK: actions
    
    public var emitEvent: ((String) -> Void)?
    public var onKeyBoardToggle: ((CGFloat) -> Void)?
    public var onMoveToParent: (() -> Void)?
    
    public var isRootController = Bool()
    
    // MARK: - override
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            onMoveToParent?()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        log.info("viewDidAppear: \(self.className)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isModal {
            clearResource()
        }
        log.info("viewDidDisappear: \(self.className)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: basic settings
        
        view.backgroundColor = UIColor.white
        
        // MARK: Keyboard Notification

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    public func clearResource(_ isDirectOrder: Bool = false) {
        if !isRootController || isDirectOrder {
            emitEvent = nil
            onKeyBoardToggle = nil
            onMoveToParent = nil
        }
    }
    
    deinit {
        log.debug("deinit Controller: \(self.className)")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Public
    
    public func reload() {
        UIView.performWithoutAnimation {
            let offset = bodyTable.contentOffset
            bodyTable.reloadData()
            bodyTable.layoutIfNeeded()
            bodyTable.setContentOffset(offset, animated: false)
        }
    }
    
    public func reuse(_ tableView: UITableView, _ index: IndexPath, _ identifier: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index)
        return cell
    }
    
    public func initialize<T: ModelProtocol>(_ model: T) {

    }
    
    // MARK: UI
    
    public var bodyTable: BaseTable = {
        let table = BaseTable()
        return table
    }()

    public let buttonClose: NavigationButton = {
        let button = NavigationButton()
        button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        return button
    }()
    
}

// MARK: Keyboard Notification

extension BaseController {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            onKeyBoardToggle?(keyboardHeight)
            toggleHeightBodyTable(keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        onKeyBoardToggle?(0)
        toggleHeightBodyTable(0)
    }
    
    fileprivate func toggleHeightBodyTable(_ height: CGFloat) {
        let tabbarHeight: CGFloat = utils.tabbar()?.tabBar.frame.size.height ?? 0.0
        if bodyTable.isConstraintsSet {
            UIView.animate(withDuration: 0.6, animations: { [unowned self] in
                if tabbarHeight == 0.0 {
                    self.bodyTable.snp.remakeConstraints({ remake in
                        remake.top.equalTo(self.view.safeArea.top).offset(0)
                        remake.bottom.equalTo(self.view.safeArea.bottom).offset(-height)
                        remake.left.equalTo(0)
                        remake.right.equalTo(0)
                    })
                } else {
                    self.bodyTable.snp.updateConstraints { (upd) in
                        upd.bottom.equalTo(self.view.safeArea.bottom).offset(-height + tabbarHeight)
                    }
                }
                self.view.layoutIfNeeded()
            })
        }
    }
    
}

extension BaseController {
 
    public func setDismissButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonClose)
        buttonClose.onTap = { [unowned self] in
            self.dismiss(animated: true, completion: {})
        }
    }
    
}
