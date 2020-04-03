//
//  Timer.swift
//  Template.ageone
//
//  Created by Konstantin Kovalenko on 02/04/2019.
//  Copyright © 2019 Konstantin Kovalenko. All rights reserved.
//

import Foundation

class CustomTimer {
    
    init(_ type: Types, onCount: (@escaping (Int) -> Void), _ interval: Int = 1, _ isInfiniti: Bool = false) {
        self.type = type
        self.interval = interval
        self.isInfiniti = isInfiniti
        self.onCount = onCount
    }
    
    public enum Types {
        case increment
        case decrement
    }
    
    public var onFinish: (() -> Void)?
    public var onCount: ((Int) -> Void)?
    
    fileprivate var type = Types.increment
    fileprivate var count = Int()
    fileprivate var current = Int()
    fileprivate var interval = Int()
    fileprivate var isInfiniti = Bool()
    fileprivate var timer: Timer?

    public func start (count: Int, onFinish: (@escaping () -> Void)) {
        self.count = count
        self.onFinish = onFinish
        timer = Timer.scheduledTimer(
            timeInterval: TimeInterval(interval),
            target: self,
            selector: #selector(counter),
            userInfo: nil,
            repeats: true
        )
    }

}

extension CustomTimer {
    
    @objc fileprivate func counter() {
        switch type {
        case .increment:
            current += 1
            onCount?(current)
        case .decrement:
            count -= 1
            onCount?(count)
        }
        if !isInfiniti {
            if current == count {
                stop()
            }
        }
    }
    
}

extension CustomTimer {

    public func stop() {
        onFinish?()
        timer?.invalidate()
        timer = nil
    }

}
