//
//  LoadingView.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift
import PromiseKit

final class LoadingView: LaunchViewController {
    
    // MARK: viewModel
    
    public var viewModel = LoadingViewModel()
    public override func initialize<T: ModelProtocol>(_ model: T) { self.viewModel.initialize(model) { self.reload() } }
    
    // MARK: ovveride
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: load data from start
        
//        activity.startAnimating()
        viewModel.startLoading {
//            self.activity.stopAnimating()
            self.emitEvent?(LoadingViewModel.EventType.onFinish.rawValue)
        }
        
    }
    
    // MARK: UI
    
}
