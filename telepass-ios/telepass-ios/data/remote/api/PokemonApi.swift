//
//  PokemonApi.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation

protocol PokemonApi {
    
    func getPokemonList(/*limit: Int,*/ offset: Int, _ success: @escaping (PokemonListDto) -> Void, _ failure: @escaping (PokemonError) -> Void)
    
    func getPokemon(byName name: String, _ success: @escaping (PokemonDto) -> Void, _ failure: @escaping (PokemonError) -> Void)
}
