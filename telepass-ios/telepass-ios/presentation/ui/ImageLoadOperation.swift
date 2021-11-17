//
//  ImageLoadOperation.swift
//  telepass-ios
//
//  Created by Luca Pavan on 13/11/21.
//

import UIKit

class ImageLoadOperation: Operation {
    
    private var repository: PokemonRepo!
    
    var completionHandler: ((UIImage?) -> ())?
    var image: UIImage?
    var pokemonId: Int!
    
    init(repo: PokemonRepo, pokemonId: Int) {
        repository = repo
        self.pokemonId = pokemonId
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        GetPokemonPicUseCase(repository: repository).invoke(pokemonId) { [weak self] dataImage in
            guard let strongSelf = self,
                  !strongSelf.isCancelled,
                  let image = UIImage(data: dataImage) else {
                      return
                  }
            strongSelf.image = image
            strongSelf.completionHandler?(image)
        } _: { [weak self] _ in
            guard let strongSelf = self, !strongSelf.isCancelled else { return }
            strongSelf.image = nil
            strongSelf.completionHandler?(nil)
        }
        
    }
}
