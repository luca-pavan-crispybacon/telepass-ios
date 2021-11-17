//
//  Resource.swift
//  telepass-ios
//
//  Created by Luca Pavan on 11/11/21.
//

import Foundation

enum Resource<T> {
    case Success(data: T)
    case Error(message: String)
    case Loading(T? = nil)
}
