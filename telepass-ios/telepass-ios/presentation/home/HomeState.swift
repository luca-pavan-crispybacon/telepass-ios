//
//  HomeState.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation

enum HomeState {
    case Empty
    case Loading
    case NamesLoaded(names: [String])
    case PokemonLoaded(pokemon: Pokemon)
    case PokemonPicLoaded(pokemonId: Int, pokemonPic: Data)
    case Error(error: PokemonError)
}
