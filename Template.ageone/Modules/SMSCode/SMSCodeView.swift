//
//  SMSCode.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 02/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ActiveLabel

final class SMSCodeView: BaseController {
    
    // MARK: viewModel
    
    public var viewModel = SMSCodeViewModel()
    
    // MARK: ovveride
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.model.timer?.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SMSCodeViewModel.Localization.title
        hideKeyboardWhenTappedAround()
        renderUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bindUI()
    }
    
    // MARK: UI
    
    // MARK: imageBottom
    
    fileprivate let imageBottom: BaseImageView = {
        var imageView = BaseImageView()
        imageView.image = R.image.auth()
        return imageView
    }()
    
    // MARK: textField
    
    fileprivate let textField: MaterialTextField = {
        let textField = MaterialTextField()
        textField.defineType(MaterialTextField.Types.sms)
        textField.placeholder = SMSCodeViewModel.Localization.placeholder
        textField.charLimit = 4
        return textField
    }()

    // MARK: labelDescription
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 15.0)
        label.textAlignment = .left
        label.textColor = utils.constants.colors.darkBlue
        label.numberOfLines = 0
        label.text = SMSCodeViewModel.Localization.description
        return label
    }()
    
//    fileprivate let labelDescription: ActiveLabel = {
//        let label = ActiveLabel()
//        label.font = UIFont(name: utils.constants.font.regular, size: 15.0)
//        label.textAlignment = .left
//        label.textColor = UIColor(hexString: "#3F3F3F") ?? UIColor()
//        label.numberOfLines = 0
//        label.isUserInteractionEnabled = true
//        return label
//    }()
    
    // MARK: buttonNext
    
    fileprivate let buttonNext: GradientButton = {
        let button = GradientButton()
        button.clipsToBounds = true
        button.setTitle(SMSCodeViewModel.Localization.button, for: UIControl.State.normal)
        button.alpha = 0.0
        return button
    }()
    
}

// MARK: private

extension SMSCodeView {
    
    fileprivate func renderUI() {
        
        // MARK: imageBottom
        
        view.addSubview(imageBottom)
        imageBottom.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(utils.variables.screenWidth)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeArea.top).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        textField.onTextEntered = { [unowned self] value in
            self.viewModel.model.code = value
        }

        // MARK: labelDescription

        view.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        // MARK: retry
        
//        let linkCounter = ActiveType.custom(pattern: SMSCodeViewModel.Localization.retrySelected)
//        labelDescription.enabledTypes = [linkCounter]
//        labelDescription.customColor[linkCounter] = utils.constants.colors.red
//        labelDescription.customSelectedColor[linkCounter] = utils.constants.colors.red.withAlphaComponent(0.8)
//        labelDescription.handleCustomTap(for: linkCounter) { _ in
//            utils.navigation()?.popViewController(animated: true)
//        }
//
        // MARK: buttonNext
        
        view.addSubview(buttonNext)
        buttonNext.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(58).priority(999)
        }
        buttonNext.onTap = { [unowned self] in
//            self.emitEvent?(SMSCodeViewModel.EventType.onValidate.rawValue)
            self.viewModel.validate {
                self.viewModel.checkSMSCode {
                    self.emitEvent?(SMSCodeViewModel.EventType.onValidate.rawValue)
                }
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
        
        // MARK: timer
        
        viewModel.model.description
            .asObservable()
            .bind(to: self.labelDescription.rx.text)
            .disposed(by: disposeBag)
        
    }
    
}
