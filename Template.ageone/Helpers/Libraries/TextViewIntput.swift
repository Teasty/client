//
//  TextViewIntput.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 06/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class TextViewIntput: BaseController {
    
    public var onFinish: ((String) -> Void)?
    fileprivate var value = String()
    
    // MARK: override
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [unowned self] in
            self.textView.becomeFirstResponder()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let value = textView.text {
            onFinish?(value)
        }
    }
    
    override func viewDidLayoutSubviews() {
        bindUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI()
    }
    
    // MARK: public
    
    public func open(_ text: String, _ placeholder: String, _ title: String) {
        textView.text = text
        textView.placeholder = placeholder
        navigationItem.title = title
        utils.navigation()?.pushViewController(self, animated: true)
    }
    
    // MARK: UI
    
    public let textView: JVFloatLabeledTextView = {
        let textView = JVFloatLabeledTextView()
        
        return textView
    }()
    
    fileprivate let buttonNext: GradientButton = {
        let button = GradientButton()
        button.clipsToBounds = true
        button.setTitle("TextViewIntput.readyButton.default".localized(), for: UIControl.State.normal)
        button.alpha = 0.0
        return button
    }()
    
}

extension TextViewIntput: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            log.verbose(text)
        }
    }
}

extension TextViewIntput {
    
    fileprivate func renderUI() {
        
        // MARK: buttonNext
        
        view.addSubview(buttonNext)
        buttonNext.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(58).priority(999)
        }
        buttonNext.onTap = {
            utils.navigation()?.popViewController(animated: true)
        }
        
        textView.delegate = self
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeArea.top).offset(20)
            make.bottom.equalTo(buttonNext.snp.top).offset(-8)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
    }
    
    fileprivate func bindUI() {
        onKeyBoardToggle = { [unowned self] height in
            UIView.animate(withDuration: 0.6, animations: {
                if height > 0 {
                    self.buttonNext.alpha = 1.0
                } else {
                    self.buttonNext.alpha = 0.0
                }
                self.buttonNext.snp.updateConstraints({ (upd) in
                    upd.bottom.equalTo(self.view.snp.bottom).offset(-height)
                })
                self.view.layoutIfNeeded()
            })
        }
    }
    
}
