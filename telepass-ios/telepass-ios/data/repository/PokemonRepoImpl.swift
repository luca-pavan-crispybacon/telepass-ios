//
//  PokemonService.swift
//  telepass-ios
//
//  Created by Luca Pavan on 11/11/21.
//

import Foundation
import Alamofire

public class PokemonRepoImpl: PokemonRepo {
    
    private var pokemonApi: PokemonApi
    private var spriteApi: SpriteApi
    
    init(pokemonApi: PokemonApi,
         spriteApi: SpriteApi) {
        self.pokemonApi = pokemonApi
        self.spriteApi = spriteApi
    }
    
    func getPokemonList(currentLoadedElements: Int, _ success: @escaping (PokemonListDto) -> Void, _ failure: @escaping (PokemonError) -> Void) {
        pokemonApi.getPokemonList(offset: currentLoadedElements, success, failure)
    }
    
    func getPokemon(byName name: String, _ success: @escaping (PokemonDto) -> Void, _ failure: @escaping (PokemonError) -> Void) {
        pokemonApi.getPokemon(byName: name, success, failure)
    }
    
    func getPokemonPic(byId id: Int, _ success: @escaping (Data) -> Void, _ failure: @escaping (PokemonError) -> Void) {
        spriteApi.getPokemonPic(byId: id, success, failure)
    }
}
