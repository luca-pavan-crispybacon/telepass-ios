//
//  LiveData.swift
//  telepass-ios
//
//  Created by Luca Pavan on 11/11/21.
//

import Foundation

class LiveData<T> {
    var value: T? = nil {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
