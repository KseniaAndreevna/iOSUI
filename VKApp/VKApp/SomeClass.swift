//
//  SomeClass.swift
//  VKApp
//
//  Created by andrey.antropov on 02.06.2021.
//

import Foundation

class SomeClass {
    
    private let isolationQueue = DispatchQueue(label: "ru.SomeClass.isolation", qos: .default)
    
    var property1: Int {
        get {
            return isolationQueue.sync {
                return _private1
            }
        }
        
        set {
            isolationQueue.async {
                self._private1 = newValue
            }
        }
    }
    
    private var _private1: Int = 0
    
    private var property2: String = ""
    
    public func set(property2: String) {
        isolationQueue.async {
            self.property2 = property2
        }
    }
    
    public func getProperty2() -> String {
        return isolationQueue.sync {
            return property2
        }
    }
}
