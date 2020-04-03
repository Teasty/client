//
//  Enum.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 23/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation

extension RawRepresentable where RawValue == String {
    var description: String {
        return rawValue
    }
}
