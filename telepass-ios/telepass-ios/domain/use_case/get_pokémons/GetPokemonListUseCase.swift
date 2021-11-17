//
//  GetPokemonListUseCase.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation

class GetPokemonListUseCase {

    private var repository: PokemonRepo
    
    init(repository: PokemonRepo) {
        self.repository = repository
    }
    
    func invoke(_ currentLoadedElements: Int = 0,
                _ success: @escaping ([String]) -> Void,
                _ failure: @escaping (PokemonError) -> Void) {
        repository.getPokemonList(currentLoadedElements: currentLoadedElements, { pokemonList in
            guard let names = pokemonList.results?.compactMap({ $0.name }) else {
                failure(PokemonError.asNoData())
                return
            }
            success(names)
        }, failure)
    }
}
