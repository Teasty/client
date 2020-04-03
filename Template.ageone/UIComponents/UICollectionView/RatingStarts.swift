//
//  RaitingSelectStarts.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 07/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class RatingStarts: BaseCollection {

    public var selectedStar = Int()
    fileprivate var ratingType = RatingType.active
    fileprivate let numberOfStars = 5
    
    
    enum RatingType: String, CaseIterable {
        case fixed
        case active
    }
    
    enum RatingMark: String, CaseIterable {
        case full
        case half
        case none
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private

    fileprivate func detectIconType() -> UIImage {
        return UIImage()
    }
    
    // MARK: public
    
    public let ratingLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    override init(customLayout: UICollectionViewFlowLayout) {
        super.init(customLayout: ratingLayout)
    }
    
    public func initialize(_ ratingType: RatingType, _ mark: Double? = nil) {
        self.ratingType = ratingType
        delegate = self
        dataSource = self
        register(RatingStartsCell.self, forCellWithReuseIdentifier: "RatingStartsCell")
    }
    
    public func getWidth(_ height: CGFloat) -> (CGFloat) {
        return height * 5 + 4 * height * 0.33
    }
    
}

// MARK: deleagte

extension RatingStarts: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfStars
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let element = elements[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RatingStartsCell",
                                                      for: indexPath) as? RatingStartsCell
        switch ratingType {
        case .fixed: break
        case .active:
            if selectedStar > indexPath.row {
                cell?.initialize(RatingMark.full)
            } else {
                cell?.initialize(RatingMark.none)
            }
            cell?.onTap = { [unowned self] in
                self.selectedStar = indexPath.row + 1
                self.reloadData()
            }
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: frame.height * 0.33, bottom: 0, right: frame.height * 0.33)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.height, height: frame.height)
    }
    
}

// MARK: Cell

class RatingStartsCell: BaseCollectionCell {
    
    public var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderUI()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: imageStar
    
    fileprivate let imageStar: BaseImageView = {
        let imageView = BaseImageView()
        return imageView
    }()
    
}

extension RatingStartsCell {
    
    fileprivate func renderUI() {
        
        // MARK: imageStar
        
        contentView.addSubview(imageStar)
        imageStar.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
    }
    
    public func initialize(_ ratingMark: RatingStarts.RatingMark) {
        switch ratingMark {
        case .full: imageStar.image = R.image.markFull()
        case .half: break
        case .none: imageStar.image = R.image.markNone()
        }
    }
    
}

extension RatingStartsCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}
