//
//  UICollectionViewCell.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 29/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    var collectionView: UICollectionView? {
        return superview as? UICollectionView
    }
    
    var indexPath: IndexPath? {
        return collectionView?.indexPath(for: self)
    }
    
}
