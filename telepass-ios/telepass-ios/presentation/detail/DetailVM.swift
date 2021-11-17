//
//  DetailVM.swift
//  telepass-ios
//
//  Created by Luca Pavan on 16/11/21.
//

import Foundation


class DetailVM {
    
    private(set) var state: LiveData<DetailState>
    
    init() {
        state = LiveData<DetailState>(.Empty)
    }
    
    func execute(action: DetailAction) {
        switch action {
        case let .ShowPokemonDetail(pokemon):
            showData(pokemon)
        }
    }
    
    private func showData(_ pokemon: Pokemon) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.state.value = .Loading
            self.state.value = .DetailLoaded(pokemon: pokemon)
        }
    }
    
}
