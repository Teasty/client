//
//  Base.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 03/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class HistoryBaseTableCell: BaseTableCell {

    public var onTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: labelDate
    
    fileprivate let labelDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 18.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelPrice
    
    fileprivate let labelPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 18.0)
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: imageFrom
    
    fileprivate let imageFrom: BaseImageView = {
        var imageView = BaseImageView()
        imageView.image = R.image.pinFrom()
        return imageView
    }()
    
    // MARK: imageTo
    
    fileprivate let imageTo: BaseImageView = {
        var imageView = BaseImageView()
        imageView.image = R.image.pinTo()
        return imageView
    }()
    
    // MARK: viewLine
    
    fileprivate let viewLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#777777") ?? UIColor()
        view.layer.cornerRadius = 0.0
        return view
    }()
    
    // MARK: labelFrom
    
    fileprivate let labelFrom: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 16.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelFromDescription
    
    fileprivate let labelFromDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 14.0)
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#878787") ?? UIColor()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelTo
    
    fileprivate let labelTo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 16.0)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: buttonRepeat
    
    public let buttonRepeat: BaseButton = {
        let button = BaseButton()
        button.setTitle("ПОВТОРИТЬ", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: utils.constants.font.bold, size: 10.0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.layer.cornerRadius = 12.0
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.clear.cgColor
        button.backgroundColor = utils.constants.colors.yellow
        return button
    }()
    
}

// MARK: Base methods

extension HistoryBaseTableCell {
    
    // MARK: renderUI

    fileprivate func renderUI() {
        
        // MARK: labelPrice
        
        contentView.addSubview(labelPrice)
        labelPrice.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.width.equalTo(80)
            make.right.equalTo(-20)
        }
        
        // MARK: labelDate
        
        contentView.addSubview(labelDate)
        labelDate.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(labelPrice.snp.left).offset(0)
        }
        
        // MARK: imageFrom
        
        contentView.addSubview(imageFrom)
        imageFrom.snp.makeConstraints { (make) in
            make.top.equalTo(labelDate.snp.bottom).offset(12)
            make.left.equalTo(20)
            make.width.equalTo(9)
            make.height.equalTo(13)
        }
        
        // MARK: labelFrom
        
        contentView.addSubview(labelFrom)
        labelFrom.snp.makeConstraints { (make) in
            make.top.equalTo(imageFrom.snp.top).offset(-3)
            make.left.equalTo(imageFrom.snp.right).offset(6)
            make.right.equalTo(-20)
        }
        
        // MARK: labelFromDescription
        
        contentView.addSubview(labelFromDescription)
        labelFromDescription.snp.makeConstraints { (make) in
            make.top.equalTo(labelFrom.snp.bottom).offset(4)
            make.left.equalTo(imageFrom.snp.right).offset(6)
            make.right.equalTo(-20)
        }
        
        // MARK: labelTo
        
        contentView.addSubview(labelTo)
        labelTo.snp.makeConstraints { (make) in
            make.top.equalTo(labelFromDescription.snp.bottom).offset(18)
            make.bottom.equalTo(-48)
            make.left.equalTo(imageFrom.snp.right).offset(6)
            make.right.equalTo(-20)
        }
        
        // MARK: imageTo
        
        contentView.addSubview(imageTo)
        imageTo.snp.makeConstraints { (make) in
            make.top.equalTo(labelTo.snp.top).offset(3)
            make.left.equalTo(20)
            make.width.equalTo(9)
            make.height.equalTo(13)
        }
        
        // MARK: viewLine
        
        contentView.addSubview(viewLine)
        viewLine.snp.makeConstraints { (make) in
            make.top.equalTo(imageFrom.snp.bottom).offset(3)
            make.centerX.equalTo(imageFrom.snp.centerX)
            make.bottom.equalTo(imageTo.snp.top).offset(-3)
            make.width.equalTo(1)
        }

        // MARK: buttonRepeat
        
        contentView.addSubview(buttonRepeat)
        buttonRepeat.snp.makeConstraints { (make) in
            make.top.equalTo(labelTo.snp.bottom).offset(8)
            make.bottom.equalTo(-16)
            make.right.equalTo(-20)
            make.width.equalTo(87)
        }
        
    }
    
    // MARK: initialize

    public func initialize(_ order: Order) {
        labelDate.text = Date(timeIntervalSince1970: TimeInterval(exactly: order.created) ?? 0).parseToString("dd MMMM в HH:mm")
        if let from = order.departure, let to = order.arrival {
            labelFrom.text = "\(from.street) \(from.house)"
            labelFromDescription.text = "\(from.porch)"
            labelTo.text = "\(to.street) \(to.house)"
        }
        labelPrice.text = "\(Int(order.price)) р."
    }
    
}

// MARK: Actions

extension HistoryBaseTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
