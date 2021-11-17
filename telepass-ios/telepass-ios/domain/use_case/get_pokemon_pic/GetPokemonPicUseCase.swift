//
//  GetPokemonPicUseCase.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation

class GetPokemonPicUseCase {

    private var repository: PokemonRepo
    
    init(repository: PokemonRepo) {
        self.repository = repository
    }
    
    func invoke(_ id: Int,
                _ success: @escaping (Data) -> Void,
                _ failure: @escaping (PokemonError) -> Void) {
        repository.getPokemonPic(byId: id, { pokemonPic in
            success(pokemonPic)
        }, failure)
    }
}
