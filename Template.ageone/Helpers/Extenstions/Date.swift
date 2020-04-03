//
//  Date.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 26/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation

extension Date {
    func parseToString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return "\(formatter.string(from: self))"
    }
}
