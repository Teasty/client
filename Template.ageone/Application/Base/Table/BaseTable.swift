//
//  BaseTable.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class BaseTable: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    public var numberOfRows = Int()
    public var isConstraintsSet = Bool()
    
    // MARK: override
    
    override init(frame: CGRect, style: UITableView.Style = UITableView.Style.plain) {
        super.init(frame: frame, style: UITableView.Style.plain)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: configureUI

extension BaseTable {
    
    fileprivate func configureUI() {
        backgroundColor = UIColor.clear
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableFooterView = UIView()
        rowHeight = UITableView.automaticDimension
        showsVerticalScrollIndicator = false
        estimatedRowHeight = 1
        keyboardDismissMode = .onDrag
    }
    
}

// MARK: renderUI

extension BaseTable {
    
    public func renderUI(_ view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeArea.top).offset(0)
            make.bottom.equalTo(view.safeArea.bottom).offset(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        isConstraintsSet = true
    }
    
    public func register(_ cell: BaseTableCell.Type) {
        self.register(cell, forCellReuseIdentifier: "\(cell)")
    }
    
}
