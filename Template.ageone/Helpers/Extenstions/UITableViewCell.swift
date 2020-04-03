//
//  UITableViewCell.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 29/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    var tableView: UITableView? {
        return superview as? UITableView
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
    
}
