//
//  CircleButton.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 06/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class CircleButton: BaseView {
    
    init(_ title: String) {
        super.init(frame: CGRect.zero)
        labelTitle.text = title
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI

    // MARK: imageIcon
    
    fileprivate let imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.layer.cornerRadius = 21.0
        imageView.layer.shadowRadius = 6.0
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        imageView.layer.shadowOffset.height = 4.0
        return imageView
    }()
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 11.0)
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#606060") ?? UIColor()
        label.numberOfLines = 0
        return label
    }()
    
    public func setTitleImage(_ image: UIImage?) {
        imageIcon.image = image
    }
    
}

extension CircleButton {
    
    fileprivate func renderUI() {
        
        // MARK: labelTitle
        
        addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(-4)
            make.width.equalTo(62)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        // MARK: imageIcon
        
        addSubview(imageIcon)
        imageIcon.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(42)
            make.height.equalTo(42)
            make.bottom.equalTo(labelTitle.snp.top).offset(-7)
        }
        
    }
    
}
