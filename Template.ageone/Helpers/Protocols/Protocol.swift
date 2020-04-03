//
//  Protocol.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 13/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

protocol FlowProtocol: class {
    var onStartFlow: (() -> Void)? { get set }
    var onFinishFlow: (() -> Void)? { get set }
    var rootController: BaseController { get set }
    func start()
    func finish()
    func eventError(_ event: String)
}

protocol ViewModelProtocol: class {
    func initialize<T: ModelProtocol>(_ model: T, completion: @escaping () -> Void)
}

protocol TableCellProtocol: class {

}

protocol ModelProtocol: class {
    
}

protocol Coordinator {
  
}
