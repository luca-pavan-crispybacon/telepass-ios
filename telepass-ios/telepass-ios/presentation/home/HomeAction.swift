//
//  HomeAction.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation

enum HomeAction {
    case GetPokemonNames(loadedElements: Int = 0)
    case GetPokemon(name: String)
    case GetPokemonPic(id: Int)
}
