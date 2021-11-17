//
//  HomeVM.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation

class HomeVM {
    
    private(set) var state: LiveData<HomeState>
    
    private let pokemonApi = PokemonApiImpl(baseUrl: Constants.shared.pokemonBaseUrl)
    private let spriteApi = SpriteApiImpl(baseUrl: Constants.shared.spriteBaseUrl)
    
    private(set) var repo: PokemonRepoImpl!
    
    init() {
        state = LiveData<HomeState>(.Empty)
        
        repo = PokemonRepoImpl(pokemonApi: pokemonApi, spriteApi: spriteApi)
    }
    
    func execute(action: HomeAction) {
        switch action {
        case let .GetPokemonNames(loadedElements):
            retrievePokemonList(loadedElements)
        case let .GetPokemon(name):
            retrievePokemon(name)
        case let .GetPokemonPic(id):
            retrievePokemonPic(id)
        }
    }
    
    private func retrievePokemonList(_ loadedElements: Int) {
        state.value = .Loading
        GetPokemonListUseCase(repository: repo).invoke(loadedElements) { names in
            self.state.value = .NamesLoaded(names: names)
        } _: { pkmError in
            self.state.value = .Error(error: pkmError)
        }
    }
    
    private func retrievePokemon(_ name: String) {
        state.value = .Loading
        GetPokemonUseCase(repository: repo).invoke(name) { pokemon in
            self.state.value = .PokemonLoaded(pokemon: pokemon)
        } _: { pkmError in
            self.state.value = .Error(error: pkmError)
        }
    }
    
    private func retrievePokemonPic(_ picId: Int) {
        state.value = .Loading
        GetPokemonPicUseCase(repository: repo).invoke(picId) { image in
            self.state.value = .PokemonPicLoaded(pokemonId: picId, pokemonPic: image)
        } _: { pkmError in
            self.state.value = .Error(error: pkmError)
        }
    }
}
