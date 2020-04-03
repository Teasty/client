//
//  BaseTableCell.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseTableCell: UITableViewCell {
    
    // MARK: rx reuse

    private(set) var disposeBag = DisposeBag()
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    // MARK: override
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        selectionStyle = .none
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public

//    public func configure(_ configuration: (() -> Void)) {
//        configuration()
//    }
    
}
