//
//  DetailState.swift
//  telepass-ios
//
//  Created by Luca Pavan on 16/11/21.
//

import Foundation

enum DetailState {
    case Empty
    case Loading
    case DetailLoaded(pokemon: Pokemon)
}
