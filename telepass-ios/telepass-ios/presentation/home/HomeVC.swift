//
//  HomeVC.swift
//  telepass-ios
//
//  Created by Luca Pavan on 11/11/21.
//

import UIKit
import Stevia

class HomeVC: UIViewController,
              UICollectionViewDataSource,
              UICollectionViewDelegate,
              UICollectionViewDataSourcePrefetching {
    
    private let vm = HomeVM()
    
    private var pokemons = [Pokemon]()
    
    private let imageLoadQueue = OperationQueue()
    private var imageLoadOperations = [IndexPath: ImageLoadOperation]()
    private var isLastPageReached = false
    private var isLoading = false
    private var collection: UICollectionView!
    
    private let NUMPER_PER_ROW: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.state.bind { state in
            guard let strongState = state else { return }
            
            switch strongState {
            case .Empty:
                self.loadData()
            case .Loading:
                self.isLoading = true
            case let .NamesLoaded(names):
                self.getPokemonFromList(names)
            case let .PokemonLoaded(pokemon):
                self.render(pokemon)
            case let .PokemonPicLoaded(pokemonPic, image):
                self.addPokemonPic(pokemonPic, image: image)
            case let .Error(error):
                self.isLoading = false
                if error.code == ErrorCode.NO_MORE_DATA {
                    self.isLastPageReached = true
                }
            }
        }
        
    }
    
    override func loadView() {
        super.loadView()
        let itemSize = UIScreen.main.bounds.width / (NUMPER_PER_ROW + 1)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        collection = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.prefetchDataSource = self
        collection.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.TAG)
        
        view.subviews(collection)
        
        collection.clipsToBounds = false
        
        collection.Top == view.safeAreaLayoutGuide.Top + 20
        collection.Left == view.safeAreaLayoutGuide.Left + 20
        collection.Right == view.safeAreaLayoutGuide.Right - 20
        collection.Bottom == view.safeAreaLayoutGuide.Bottom
    }
    
    private func loadData() {
        vm.execute(action: .GetPokemonNames(loadedElements: pokemons.count))
    }
    
    private func getPokemonFromList(_ names: [String]) {
        for name in names {
            vm.execute(action: .GetPokemon(name: name))
        }
    }
    
    private func render(_ pokemon: Pokemon) {
        isLoading = false
        pokemons = pokemons.sorted { $0.id ?? 0 < $1.id ?? 0 }
        if pokemons.firstIndex(where: { $0.id == pokemon.id }) == nil {
            pokemons.append(pokemon)
        }
        getPokemonPic(pokemon.id ?? 0)
//        collection.reloadData()
    }
    
    private func getPokemonPic(_ pokemonId: Int) {
        vm.execute(action: .GetPokemonPic(id: pokemonId))
    }
    
    private func addPokemonPic(_ pokemonId: Int, image: Data) {
        isLoading = false
        guard let index = pokemons.firstIndex(where: { $0.id == pokemonId }) else { return }
        var pokemon = pokemons[index]
        pokemon.dataImage = image
        pokemons[index] = pokemon
        collection.reloadData()
    }
    
    //    MARK: - UICollection functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.TAG, for: indexPath) as? PokemonCell else {
            fatalError("Expected `\(PokemonCell.self)` type for reuseIdentifier \(PokemonCell.TAG).")
        }
        
        let pokemon = pokemons[indexPath.row]
        let identifier = pokemon.id
        
        cell.representedIdentifier = identifier
        
        if let strongImage = pokemons[indexPath.row].dataImage {
            cell.bind(pokemon)
            cell.setImage(UIImage(data: strongImage))
        } else {
            cell.bind(nil)
            if let imageLoadOperation = imageLoadOperations[indexPath],
               let image = imageLoadOperation.image {
                cell.bind(pokemon)
                cell.setImage(image)
            } else if let strongId = pokemons[indexPath.row].id {
                let imageLoadOperation = ImageLoadOperation(repo: vm.repo, pokemonId: strongId)
                imageLoadOperation.completionHandler = { [weak self] prefetchedImage in
                    guard let strongSelf = self else {
                        return
                    }
                    guard cell.representedIdentifier == identifier else { return }
                    cell.bind(pokemon)
                    cell.setImage(prefetchedImage)
                    strongSelf.imageLoadOperations.removeValue(forKey: indexPath)
                }
                imageLoadQueue.addOperation(imageLoadOperation)
                imageLoadOperations[indexPath] = imageLoadOperation
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isLastPageReached &&
            !isLoading &&
            indexPath.row == pokemons.count - 1 {
            loadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DetailVC.showDetail(sender: self, pokemons[indexPath.row])
    }

    //    MARK: - UICollection - Prefetch
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let imageLoadOperation = imageLoadOperations[indexPath] {
            imageLoadOperation.cancel()
            imageLoadOperations.removeValue(forKey: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let _ = imageLoadOperations[indexPath],
                  let strongId = pokemons[indexPath.row].id else {
                      return
                  }
            
            let imageLoadOperation = ImageLoadOperation(repo: vm.repo, pokemonId: strongId)
            imageLoadQueue.addOperation(imageLoadOperation)
            imageLoadOperations[indexPath] = imageLoadOperation
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let imageLoadOperation = imageLoadOperations[indexPath] else {
                return
            }
            imageLoadOperation.cancel()
            imageLoadOperations.removeValue(forKey: indexPath)
        }
    }
}
