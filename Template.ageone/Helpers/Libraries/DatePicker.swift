//
//  DatePicker.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class DatePicker {
    
    public var alertTitle = ""
    public var alertButton = "Отмена"
    
    public func open(mode: UIDatePicker.Mode = .date,
                     minuteInterval: Int = 5,
                     minimalDate: Date = Date(),
                     completion: @escaping (Date) -> Void) {
        
        let datePicker: UIDatePicker = {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = mode
            datePicker.minuteInterval = minuteInterval
            datePicker.minimumDate = minimalDate
            datePicker.tintColor = utils.constants.colors.darkGray
            datePicker.maximumDate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())
            return datePicker
        }()
        
        let message = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        let alert = UIAlertController(
            title: alertTitle,
            message: message,
            preferredStyle: UIAlertController.Style.actionSheet
        )
        alert.isModalInPopover = true
        alert.addAction(UIAlertAction(title: alertButton,
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in completion(datePicker.date) })
        )
        
        alert.view.addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(2)
            make.bottom.equalTo(-60)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        utils.controller()?.present(alert, animated: true)

    }
    
}
