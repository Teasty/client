//
//  SingleSelectList.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 29/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class SingleSelectList: BaseCollection {
    
    public var callback: ((String) -> Void)?
    fileprivate var selected = String()
    fileprivate var elements = [Element]()
    
    public struct Element {
        var name = ""
        var value = ""
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: public
    
    public func initialize(_ elements: [Element]) {
        delegate = self
        dataSource = self
        register(SingleSelectListCell.self, forCellWithReuseIdentifier: "SingleSelectListCell")
        self.elements = elements
        if let unwarp = elements.first {
            selected = unwarp.value
        }
        reloadData()
    }
    
}

// MARK: deleagte

extension SingleSelectList: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = elements[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleSelectListCell",
                                                      for: indexPath) as? SingleSelectListCell
        cell?.callback = { [unowned self] value in
            self.selected = value
            self.callback?(value)
            self.reloadData()
        }
        cell?.initialize(element, selected)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/3, height: 53)
    }
    
}

// MARK: Cell

class SingleSelectListCell: BaseCollectionCell {
    
    public var callback: ((String) -> Void)?
    fileprivate var element = SingleSelectList.Element()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderUI()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 15.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.text = "test"
        return label
    }()
    
    /// MARK: viewBottomBorder
    
    fileprivate let viewBottomBorder: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0.0
        view.layer.borderWidth = 0.0
        view.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = UIColor(hexString: "#15CB8A") ?? UIColor()
        return view
    }()
    
}

// MARK: renderUI

extension SingleSelectListCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: labelTitle
        
        self.contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        // MARK: viewBottomBorder
        
        labelTitle.addSubview(viewBottomBorder)
        viewBottomBorder.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(3)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ element: SingleSelectList.Element, _ selected: String) {
        self.element = element
        labelTitle.text = element.name
        toggle(selected)
    }
    
    // MARK: func
    
    public func toggle(_ selected: String) {
        if selected == self.element.value {
            labelTitle.textColor = UIColor(hexString: "#15CB8A") ?? UIColor()
            viewBottomBorder.backgroundColor = UIColor(hexString: "#15CB8A") ?? UIColor()
        } else {
            labelTitle.textColor = UIColor.black
            viewBottomBorder.backgroundColor = UIColor.clear
        }
    }
    
}

extension SingleSelectListCell {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        callback?(self.element.value)
    }
    
}
