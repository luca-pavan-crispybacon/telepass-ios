//
//  GetPokemonUseCase.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation

class GetPokemonUseCase {

    private var repository: PokemonRepo
    
    init(repository: PokemonRepo) {
        self.repository = repository
    }
    
    func invoke(_ name: String,
                _ success: @escaping (Pokemon) -> Void,
                _ failure: @escaping (PokemonError) -> Void) {
        repository.getPokemon(byName: name, { pokemonDto in
            success(pokemonDto.toPokemon())
        }, failure)
    }
}
