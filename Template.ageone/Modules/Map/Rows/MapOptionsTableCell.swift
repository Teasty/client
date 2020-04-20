//
//  Options.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 03/05/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class MapOptionsTableCell: BaseTableCell {

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
        collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collection.register(MapOptionsCollectionCell.self)
        return collection
    }()
    
}

// MARK: Base methods

extension MapOptionsTableCell {
    
    // MARK: renderUI

    fileprivate func renderUI() {
        
        // MARK: collection
        
        contentView.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        collection.snp.makeConstraints { (make) in
            make.top.equalTo(14)
            make.bottom.equalTo(0)
            make.width.equalTo(300)
            make.centerX.equalTo(contentView.snp.centerX).offset(-5)
            make.height.equalTo(45).priority(999)
        }
    
    }
    
    // MARK: initialize

    public func initialize() {
        UserDefaults.standard.rx
            .observe(String.self, "user_paymentType")
            .subscribe({ [unowned self] value in
                self.collection.reloadData()
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: Actions

extension MapOptionsTableCell {
    @objc func action(_ sender: UITapGestureRecognizer) {
        onTap?()
    }
}

extension MapOptionsTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapOptionsCollectionCell",
                                                      for: indexPath) as? MapOptionsCollectionCell
        switch indexPath.row {
        case 0:
            var timeText = "Сейчас"
//            if rxData.order.value.timeType == .preliminary {
//                timeText = rxData.order.value.time.parseToString("dd.MM к HH:mm")
//            }
            cell?.initialize(timeText, R.image.optionTime())
            cell?.onTap = { [unowned self] in
//                let datePicker = DatePicker()
//                datePicker.open(mode: UIDatePicker.Mode.dateAndTime, minuteInterval: 5, minimalDate: Date(), completion: { [unowned self] date in
//                    let time = date.timeIntervalSince1970 - Date().timeIntervalSince1970
//                    var order = rxData.order.value
//                    order.time = date
//                    order.timeType = .current
//                    if time > 15 * 60 {
//                        order.timeType = .preliminary
//                    }
//                    rxData.order.accept(order)
//                    self.collection.reloadData()
//                })
            }
            
        case 1:
            var payment = "Наличные"
            if user.info.paymentType != "cash" {
                payment = "Карта \(utils.formatter.card(utils.realm.payment.getObjects().first(where: { $0.hashId == user.info.paymentType })?.cardNumber ?? "****************"))"
//                let realm = try! Realm()
//                if let card = realm.object(ofType: Payment.self, forPrimaryKey: user.info.paymentType) {
//
//                }
            }
            cell?.initialize(payment, R.image.optionPayment())
            cell?.onTap = { [unowned self] in
                router.transition(.present, coordinator.stack.0[1].navigation)
                self.collection.reloadData()
            }
            
        case 2:
            cell?.initialize("Пожелания", R.image.optionWish())
            cell?.onTap = { [unowned self] in
                coordinator.runFlowWishList()
                self.collection.reloadData()
            }
            
        default: break
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
        return CGSize(width: 100, height: 45)
    }
    
}
