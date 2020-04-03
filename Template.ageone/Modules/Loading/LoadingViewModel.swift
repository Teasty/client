//
//  LoadingViewModel.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 16/03/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation
import PromiseKit
import RealmSwift

// MARK: Events

extension LoadingViewModel {
    
    public enum EventType: String, CaseIterable {
        
        case onFinish
        
        static func string(_ string: String) -> EventType? {  return self.allCases.first { "\($0)" == string } }
    }
    
}

// MARK: View Model

extension LoadingViewModel {
    
    func initialize<T: ModelProtocol>(_ receivedModel: T, completion: @escaping () -> Void) {
        guard let unwarp = receivedModel as? LoadingModel else { log.error("Cant unwarp model"); return }
        model = unwarp; completion()
    }
    
}

final class LoadingViewModel: ViewModelProtocol {
    
    // MARK: var
    
    public var model = LoadingModel()
    public var numberOfRows = 0
    
    // MARK: - Localization
    
    enum Localization {
        static let title                     = "Loading.Title".localized()
    }
    
    // MARK: public
    
    public func startLoading(completion: @escaping () -> Void) {
//        after(seconds: 1.0).done {
//            completion()
//        }
//        firstly {
//            self.detectUserLocation()
//        }.done { _ in
//            completion()
//        }.catch { (error) in
//            log.error("Error detected: \(error)")
//        }

        
        firstly { [unowned self] in
            self.detectUserLocation()
        }.done { _ in
            api.sendFCMToken {
                completion()
            }
        }.catch { (error) in
            log.error("Error detected: \(error)")
        }
    }
    
    public func detectUserLocation() -> Promise<Void> {
        return Promise { seal in
            locationManager.onLocationDetected = {
                seal.fulfill_()
            }
            locationManager.requestUserLocation(.inUse, singleDetection: true)
        }
    }
    
}

// MARK: Model

class LoadingModel: ModelProtocol {
    
}
