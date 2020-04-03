//
//  ViewDivider.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 30/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit

class ViewDivider: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        rednderUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    // MARK: viewLine
    
    fileprivate let viewLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#D9D9D9") ?? UIColor()
        return view
    }()

    // MARK: configureUI

    fileprivate func configureUI() {
        backgroundColor = UIColor(hexString: "#F7F7F7") ?? UIColor()
    }
    
    fileprivate func rednderUI() {
        addSubview(viewLine)
        viewLine.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
        }
        
    }
    
}
