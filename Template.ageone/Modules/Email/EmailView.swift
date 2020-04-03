//
//  Email.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class EmailView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = EmailViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = EmailViewModel.Localization.title
        hideKeyboardWhenTappedAround()
        renderUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bindUI()
    }
    
    // MARK: UI
    
    // MARK: textField
    
    fileprivate let textField: MaterialTextField = {
        let textField = MaterialTextField()
        textField.defineType(MaterialTextField.Types.email)
        textField.text = user.email
        textField.placeholder = EmailViewModel.Localization.placeholder
        return textField
    }()
    
    // MARK: labelDescription
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 15.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.darkBlue
        label.numberOfLines = 0
        label.text = EmailViewModel.Localization.description
        return label
    }()
    
    // MARK: buttonNext
    
    fileprivate let buttonNext: GradientButton = {
        let button = GradientButton()
        button.setTitle(EmailViewModel.Localization.button, for: UIControl.State.normal)
        button.alpha = 0.0
        return button
    }()
    
    // MARK: imageBottom
    
    fileprivate let imageBottom: BaseImageView = {
        var imageView = BaseImageView()
        imageView.image = R.image.auth()
        return imageView
    }()
    
    // MARK: labelAgreement
    
    fileprivate let labelAgreement: LabelActive = {
        let label = LabelActive()
        label.font = UIFont(name: utils.constants.font.regular, size: 14.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.darkBlue
        label.numberOfLines = 0
        label.initialize(
            "\(EmailViewModel.Localization.cancel), \(EmailViewModel.Localization.cancelButton)",
            "\(EmailViewModel.Localization.cancelButton)",
            utils.constants.colors.red
        )
        return label
    }()
    
}

// MARK: private

extension EmailView {
    
    fileprivate func renderUI() {
        
        // MARK: imageBottom
        
        view.addSubview(imageBottom)
        imageBottom.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(utils.variables.screenWidth)
        }
        
        // MARK: textField
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeArea.top).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        textField.onTextEntered = { [unowned self] value in
            self.viewModel.model.email = value
        }
        
        // MARK: labelDescription
        
        view.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        // MARK: labelAgreement
        
        view.addSubview(labelAgreement)
        labelAgreement.snp.makeConstraints { (make) in
            make.top.equalTo(labelDescription.snp.bottom).offset(16)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        labelAgreement.onTap = { [unowned self] in
            self.viewModel.skipEmail {
                self.emitEvent?(EmailViewModel.EventType.onSkip.rawValue)
            }
        }
        
        // MARK: buttonNext
        
        view.addSubview(buttonNext)
        buttonNext.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(58).priority(999)
        }
        buttonNext.onTap = { [unowned self] in
            self.viewModel.validate {
                self.emitEvent?(EmailViewModel.EventType.onValidate.rawValue)
            }
        }
        
    }
    
    func bindUI() {
        
        // MARK: Keyboard
        
        onKeyBoardToggle = { [unowned self] height in
            UIView.animate(withDuration: 0.6, animations: {
                if height > 0 {
                    self.buttonNext.alpha = 1.0
                } else {
                    self.buttonNext.alpha = 0.0
                }
                self.buttonNext.snp.updateConstraints({ (upd) in
                    let tabbarHeight = utils.tabbar()?.tabBar.frame.size.height ?? 0.0
                    upd.bottom.equalTo(self.view.snp.bottom).offset(-height + tabbarHeight)
                })
                self.view.layoutIfNeeded()
            })
        }

    }
    
}
