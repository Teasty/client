//
//  BaseViewModel.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 02/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import RxSwift
import RxCocoa

class BaseViewModel {

    public var onRealmUpdate: (() -> Void)?
    
    public enum FactoryType {
        case count, cell
    }
    public let disposeBag = DisposeBag()
    
    public func unwarpError(){
        log.error("Cant unwarp model")
    }
    
}
