//
//  LaunchViewController.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 14/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import SwiftyGif

class LaunchViewController: BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderUI()
    }
    
    // MARK: UI

    // MARK: imageLaunch
    
    fileprivate let imageLaunch: BaseImageView = {
        var imageView = BaseImageView()
        imageView.image = R.image.launchScreen()
        return imageView
    }()
    
    // MARK: imageLogo
    
    fileprivate let imageLogo: BaseImageView = {
        var imageView = BaseImageView()
        imageView.image = R.image.logo()
        return imageView
    }()
    
//    public let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.bold, size: 18.0)
        label.textAlignment = .center
        label.textColor = utils.constants.colors.darkBlue
        label.numberOfLines = 0
        label.text = LoadingViewModel.Localization.title
        return label
    }()
    
//    // MARK: labelDescription
//
//    fileprivate let labelText: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: utils.constants.font.regular, size: 16.0)
//        label.textAlignment = .center
//        label.textColor = UIColor.white
//        label.numberOfLines = 0
//        label.text = "Launch.Description".localized()
//        return label
//    }()
    
}

// MARK: private

extension LaunchViewController {
    
    fileprivate func renderUI() {
        
        // MARK: labelTitle
        
//        view.addSubview(labelTitle)
//        labelTitle.snp.makeConstraints { (make) in
//            make.centerY.equalTo(view.snp.centerY).offset(-40)
//            make.centerX.equalTo(view.snp.centerX)
//            make.width.equalTo(utils.variables.screenWidth * 0.7)
//        }
//
//        // MARK: labelText
//
//        view.addSubview(labelText)
//        labelText.snp.makeConstraints { (make) in
//            make.top.equalTo(labelTitle.snp.bottom).offset(10)
//            make.centerX.equalTo(view.snp.centerX)
//            make.width.equalTo(utils.variables.screenWidth * 0.7)
//        }
        
        // MARK: image

        view.addSubview(imageLaunch)
        imageLaunch.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(0)
            make.width.equalTo(utils.variables.screenWidth)
            make.height.equalTo(utils.variables.screenWidth / 8 * 9)
        }
        
        // MARK: labelTitle
        
        view.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(imageLaunch.snp.top).offset(0)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        // MARK: imageLogo
        
        view.addSubview(imageLogo)
        imageLogo.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelTitle.snp.top).offset(-4)
            make.width.equalTo(276)
            make.height.equalTo(73)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        // MARK: activity

//        view.addSubview(activity)
//        activity.startAnimating()
//        activity.snp.makeConstraints { (make) in
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//            make.centerX.equalTo(view.snp.centerX)
//            make.bottom.equalTo(view.safeArea.bottom).offset(-40)
//        }
        
    }
    
}
