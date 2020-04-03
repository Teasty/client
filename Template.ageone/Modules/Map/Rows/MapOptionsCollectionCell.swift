//
//  MapOptionsCollectionCell.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class MapOptionsCollectionCell: BaseCollectionCell {
    
    public var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderUI()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: labelName
    
    fileprivate let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 14.0)
        label.textAlignment = .center
        label.textColor = utils.constants.colors.lightGray
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: imageIcon
    
    fileprivate let imageIcon: BaseImageView = {
        var imageView = BaseImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
}

// MARK: renderUI

extension MapOptionsCollectionCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: labelName
        
        contentView.addSubview(labelName)
        labelName.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        // MARK: imageIcon
        
        contentView.addSubview(imageIcon)
        imageIcon.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelName.snp.top).offset(-5)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(_ text: String, _ image: UIImage?) {
        labelName.text = text
        imageIcon.image = image
    }
    
}

extension MapOptionsCollectionCell {
    
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
    
}
