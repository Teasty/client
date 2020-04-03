//
//  BasrCollectionCell.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseCollectionCell: UICollectionViewCell {
    
    // MARK: rx reuse
    
    private(set) var disposeBag = DisposeBag()
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
}
