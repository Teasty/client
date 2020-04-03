//
//  Moving.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 06/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class MapMovingTableCell: BaseTableCell {
    
    public var onTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        renderUI()
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 20.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: labelNumber
    
    fileprivate let labelNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 34.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: labelPayment
    
    fileprivate let labelPayment: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 20.0)
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: labelPrice
    
    fileprivate let labelPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 28.0)
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.numberOfLines = 1
        return label
    }()
    
    public let buttonCancel = CircleButton("Отменить поездку")
    public let buttonCall = CircleButton("Позвонить водителю")
    
}

// MARK: Base methods

extension MapMovingTableCell {
    
    // MARK: renderUI
    
    fileprivate func renderUI() {
        
        // MARK: buttonCall
        
        contentView.addSubview(buttonCall)
        buttonCall.snp.makeConstraints { (make) in
            make.bottom.equalTo(-16)
            make.left.equalTo(16)
        }
        
        // MARK: buttonCancel
        
        contentView.addSubview(buttonCancel)
        buttonCancel.snp.makeConstraints { (make) in
            make.bottom.equalTo(-16)
            make.left.equalTo(buttonCall.snp.right).offset(8)
        }
        
        // MARK: labelNumber
        
        contentView.addSubview(labelNumber)
        labelNumber.snp.makeConstraints { (make) in
            make.bottom.equalTo(buttonCall.snp.top).offset(-28)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        // MARK: labelTitle
        
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(labelNumber.snp.top).offset(-10)
        }
        
        // MARK: labelPayment
        
        contentView.addSubview(labelPayment)
        labelPayment.snp.makeConstraints { (make) in
            make.bottom.equalTo(-20)
            make.left.equalTo(buttonCancel.snp.right).offset(8)
            make.right.equalTo(-20)
        }
        
        // MARK: labelPrice
        
        contentView.addSubview(labelPrice)
        labelPrice.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelPayment.snp.top).offset(-6)
            make.left.equalTo(buttonCancel.snp.right).offset(8)
            make.right.equalTo(-20)
        }
        
    }
    
    // MARK: initialize
    
    public func initialize(currentOrder: Order?) {
        guard let order = currentOrder else { return }
        //        log.verbose(order)
        if order.__status == "accepted" || order.__status == "onWay" {
            if let driverName = order.driver?.firstName, let expectedTime = currentOrder?.timeDriverExpected, let accepted = currentOrder?.timeDriverAccepted {
                let timeRemaining = Int((expectedTime + accepted - Int(Date().timeIntervalSince1970)))
                var text = ""
                log.info(timeRemaining)
                let minuts = timeRemaining / 60
                let seconds = String(format: "%02d", timeRemaining % 60)

                if expectedTime == 0 {
                     text = "Водитель \(driverName) на месте"
                } else if timeRemaining > 0 {
                    text = "Через \(minuts):\(seconds) приедет \(driverName)"
                } else {
                    text = "Водитель \(driverName) немного опаздывает"
                }
                
                if let car = order.driver?.car {
                    text += "\n\(String(describing: car.model)) (\(self.parseCarColor(car.color)))"
                    self.labelNumber.text = "\(String(describing: car.carNum))"
                }
                
                self.labelTitle.text = text
            }
        }
        
        if order.__status == "waitingForClient" {
            var text = String()
            if let driver = currentOrder?.driver {
                text = "Вас ожидает \(String(describing: driver.firstName))"
                if let car = driver.car {
                    text += "\n\(String(describing: car.model)) (\(self.parseCarColor(car.color)))"
                    self.labelNumber.text = "\(String(describing: car.carNum))"
                }
            }
            
            self.labelTitle.text = text
        }
        
        labelPayment.text = currentOrder?.paymentType == "cash" ? "наличными" : "по карте"
        
        labelPrice.text = "\(Int(order.price)) руб"
        
        buttonCall.setTitleImage(R.image.phoneCall())
        buttonCancel.setTitleImage(R.image.orderCancel())
    }
    
    fileprivate func parseCarColor(_ color: String?) -> String {
        switch color {
        case "blue": return "синий"
        case "yellow": return "жёлтый"
        case "white": return "белый"
        case "red": return "красный"
        case "gray": return "серый"
        default: return "чёрный"
        }
    }
    
}

// MARK: Actions

extension MapMovingTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
