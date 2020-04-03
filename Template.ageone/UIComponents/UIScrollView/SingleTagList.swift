//
//  SingleTagList.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class SingleTagList: UIScrollView {
    
    public var onTap: ((String) -> Void)?
    public var selected = String()
    fileprivate var elements = [SingleTagList.Element]()
    fileprivate var tags = [SingleTagListButton]()
    
    public struct Element {
        var name = ""
        var value = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SingleTagList {
    
    fileprivate func renderUI() {
        contentSize.width = 12
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    public func initialize(_ elements: [SingleTagList.Element]) {
        for (index, element) in elements.enumerated() {
            let button = SingleTagListButton()
            button.initialize(element)
            button.onTap = { [unowned self] value in
                if self.selected == value {
                    self.selected = ""
                } else {
                    self.selected = value
                }
                self.selectTag(self.selected)
                self.onTap?(self.selected)
            }
            tags.append(button)
            addSubview(button)
            button.snp.makeConstraints { (make) in
                make.top.equalTo(16)
                make.height.equalTo(26)
                if index == 0 {
                    make.left.equalTo(12)
                } else {
                    make.left.equalTo(tags[index - 1].snp.right).offset(8)
                }
            }
            button.layoutIfNeeded()
            contentSize.width += button.frame.width + 8
        }
    }
    
    fileprivate func selectTag(_ value: String) {
        for tag in tags {
            if tag.element.value == value {
                tag.toggle(true)
            } else {
                tag.toggle(false)
            }
        }
    }
    
}

// MARK: Button

class SingleTagListButton: UIButton {
    
    public var onTap: ((String) -> Void)?
    
    public var element = SingleTagList.Element()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: func
    
    public func toggle(_ isSelected: Bool) {
        if isSelected {
            backgroundColor = UIColor(hexString: "#15CB8A") ?? UIColor()
            setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else {
            backgroundColor = UIColor.white
            setTitleColor(UIColor(hexString: "#15CB8A") ?? UIColor(), for: UIControl.State.normal)
        }
    }

    fileprivate func configureUI() {
        layer.borderWidth = 1.0
        layer.cornerRadius = 13.0
        layer.borderColor = UIColor(hexString: "#15CB8A")?.cgColor ?? UIColor().cgColor
        backgroundColor = UIColor.white
        titleLabel?.font =  UIFont(name: utils.constants.font.regular, size: 13)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        setTitleColor(UIColor(hexString: "#15CB8A") ?? UIColor(), for: UIControl.State.normal)
    }
    
    public func initialize(_ element: SingleTagList.Element) {
        self.element = element
        setTitle(element.name, for: UIControl.State.normal)
    }
    
}

extension SingleTagListButton {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?(self.element.value)
    }
    
}
