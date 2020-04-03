//
//  BasrCollection.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class BaseCollection: UICollectionView {
    
    public let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    init(customLayout: UICollectionViewFlowLayout) {
        super.init(frame: CGRect.zero, collectionViewLayout: customLayout)
        configureUI()
    }
    
    init() {
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: configureUI
    
    fileprivate func configureUI() {
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        isPrefetchingEnabled = true
        isPagingEnabled = false
        bounces = true
        decelerationRate = UIScrollView.DecelerationRate.normal
    }
    
    // MARK: func

    public func register(_ cell: BaseCollectionCell.Type) {
        self.register(cell, forCellWithReuseIdentifier: "\(cell)")
    }
    
}
