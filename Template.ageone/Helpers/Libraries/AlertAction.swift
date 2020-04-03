//
//  AlertAction.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import Foundation

class AlertAction {
    
    // MARK: views

    fileprivate let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    // MARK: public
    
    public func create(_ title: String, _ message: String = "", _ image: UIImage? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let image = image {
            alert.title = "\n\n\n\n\n\n\(alert.title ?? "")"
            let imageView: UIImageView = {
                let imageView = UIImageView()
                imageView.image = image
                return imageView
            }()
            alert.view.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.equalTo(28)
                make.centerX.equalTo(alert.view.snp.centerX)
                make.height.equalTo(100)
                make.width.equalTo(100)
            }
            
        }
        return alert
    }
    
    
    public func show(_ alert: UIAlertController) {
        utils.controller()?.present(alert, animated: true, completion: nil)
    }

    public func message(
            _ title: String,
            _ message: String = "",
            fButtonName: String = "Ок",
            fButtonAction: @escaping (() -> Void) = ({ })) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let fButton = UIAlertAction.init(title: fButtonName, style: UIAlertAction.Style.default) { _ in
            fButtonAction()
        }
        alert.addAction(fButton)
        utils.controller()?.present(alert, animated: true, completion: nil)
    }
    
    public func showAppExitMessage(_ message: String) {
        alertAction.message("Предупреждение",
                            message,
                            fButtonName: "Ок",
                            fButtonAction: {
                                UIControl().sendAction(#selector(NSXPCConnection.suspend),
                                to: UIApplication.shared, for: nil)
        })
    }
    
    public struct ActionSheetElement {
        var name = String()
        var value = String()
    }
    
    public func actionSheet(
            title: String,
            message: String = "",
            actions: [ActionSheetElement],
            selected: String,
            completion: @escaping (String) -> Void) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.actionSheet)
        for element in actions {
            let action = UIAlertAction(title: element.name, style: UIAlertAction.Style.default, handler: { _ in
                completion(element.value)
            })
            if selected == element.value {
                action.setValue(R.image.checkmark()?.withRenderingMode(.alwaysOriginal), forKey: "image")
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: nil))
        utils.controller()?.present(alert, animated: true, completion: nil)
    }
    
    // MARK: loading

}
