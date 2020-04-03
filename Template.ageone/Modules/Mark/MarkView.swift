//
//  Mark.swift
//  Ageone development (ageone.ru)
//
//  Created by Konstantin Kovalenko on 29/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class MarkView: BaseController, UIAdaptivePresentationControllerDelegate {
    
    // MARK: viewModel
    
    public var viewModel = MarkViewModel()
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = MarkViewModel.Localization.title
        renderUI()
        bindUI()
    }
    
    // MARK: UI
    
    let ratingStarts = RatingStarts()
    
    // MARK: imageLogo
    
    fileprivate let imageLogo: BaseImageView = {
        let imageView = BaseImageView()
        imageView.image = R.image.logoSingle()
        return imageView
    }()
    
    fileprivate let button: ShadowButton = {
        let button = ShadowButton()
        button.setTitle("Отправить", for: UIControl.State.normal)
        return button
    }()
    
    // MARK: labelDescription
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.regular, size: 15.0)
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#686868") ?? UIColor()
        label.numberOfLines = 0
        label.text = "Нам очень важно Ваше мнение о качестве сервиса !"
        return label
    }()
    
    // MARK: labelTitle
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: utils.constants.font.medium, size: 18.0)
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#242839") ?? UIColor()
        label.numberOfLines = 0
        label.text = "Оцените, пожалуйста, Вашу поездку"
        return label
    }()
    
}

// MARK: private

extension MarkView {
    
    fileprivate func renderUI() {
        
        // MARK: imageLogo
        
        view.addSubview(imageLogo)
        imageLogo.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(65)
            make.width.equalTo(65)
        }
        
        // MARK: ratingStarts
        
        view.addSubview(ratingStarts)
        let starHeight = utils.variables.screenWidth * 0.1
        ratingStarts.snp.makeConstraints { (make) in
            make.top.equalTo(imageLogo.snp.bottom).offset(utils.variables.screenHeight * 0.12)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(starHeight)
            make.width.equalTo(ratingStarts.getWidth(starHeight))
        }
        ratingStarts.initialize(RatingStarts.RatingType.active)
        
        
        // MARK: button
        
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        button.onTap = { [unowned self] in
            
            log.info(self.ratingStarts.selectedStar)
            
            if self.ratingStarts.selectedStar > 0 {
                api.request([
                    "router": "rateOrder",
                    "orderHashId": rxData.currentOrder?.hashId,
                    "rate": self.ratingStarts.selectedStar], completion: { json in
                        log.verbose(api.parcer.parseOrder(json["Order"]))
                        user.info.rateOrderViewButtonIsTapped = true
                        rxData.state.accept(.current)
                })
                utils.controller()?.dismiss(animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    let alert = alertAction.create("Вы еще не выбрали оценку.")
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    alertAction.show(alert)
                }
            }
        }
        
        // MARK: labelDescription
        
        view.addSubview(labelDescription)
        labelDescription.snp.makeConstraints { (make) in
            make.bottom.equalTo(imageLogo.snp.top).offset(-utils.variables.screenHeight * 0.07)
            make.width.equalTo(240)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        // MARK: labelTitle
        
        view.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(labelDescription.snp.top).offset(-6)
            make.width.equalTo(240)
            make.centerX.equalTo(view.snp.centerX)
        }
        
    }
    
    fileprivate func bindUI() {
    }
    
}
