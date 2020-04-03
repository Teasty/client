//
//  Tariffs.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 03/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class MapTariffsTableCell: BaseTableCell {

    public var onTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.action(_:))))
        renderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    public let collection: BaseCollection = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            return layout
        }()
        let collection = BaseCollection(customLayout: layout)
        collection.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collection.register(MapTariffsCollectionCell.self)
        return collection
    }()
    
}

// MARK: Base methods

extension MapTariffsTableCell {
    
    // MARK: renderUI

    fileprivate func renderUI() {
        
        // MARK: collection
        
        contentView.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(97).priority(999)
        }
        
    }
    
    // MARK: initialize

    public func initialize() {
        
    }
    
}

// MARK: Actions

extension MapTariffsTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}

extension MapTariffsTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return utils.realm.tariff.getObjects().count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = utils.realm.tariff.getObjects().sorted { (t1, t2) -> Bool in
           t1.serialNumber < t2.serialNumber
        }[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapTariffsCollectionCell",
                                                      for: indexPath) as? MapTariffsCollectionCell
        cell?.initialize(cellData)
        cell?.onTap = { [unowned self] in
            var order = rxData.order.value
            order.tariff = cellData
            rxData.order.accept(order)
             self.collection.reloadData()
            api.requestPrice {
//                self.collection.reloadData()
            }
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = max(95, (utils.variables.screenWidth - 30) / 3)
        return CGSize(width: width, height: 97)
    }
    
}
