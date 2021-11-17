//
//  DetailVC.swift
//  telepass-ios
//
//  Created by Luca Pavan on 16/11/21.
//

import Foundation
import UIKit
import Stevia

class DetailVC: UIViewController {
    
    private var vm = DetailVM()
    
    private var pokemon: Pokemon!
    
    private let image = UIImageView()
    private let titleName = UILabel()
    private let loader = UIActivityIndicatorView()
    
    public static func showDetail(sender: UIViewController, _ pokemon: Pokemon) {
        let detailVC = DetailVC()
        detailVC.pokemon = pokemon
        detailVC.modalTransitionStyle = .coverVertical
        detailVC.modalPresentationStyle = .formSheet
        sender.present(detailVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.state.bind { state in
            guard let strongState = state else { return }
            
            switch strongState {
            case .Empty:
                self.loadData()
            case let .DetailLoaded(pokemon):
                self.showDetail(pokemon: pokemon)
            case .Loading:
                self.showLoader()
            }
        }
        
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        if #available(iOS 13.0, *) {
            loader.style = .large
        } else {
            loader.style = .whiteLarge
        }
        
        let padding = 20
        
        view.subviews(
            image,
            titleName,
            loader
        )
        
        image.Top == view.safeAreaLayoutGuide.Top
        image.size(120).centerHorizontally()
        
        titleName.Top == image.Bottom + padding
        titleName.fillHorizontally(padding: padding)
        titleName.font = UIFont.systemFont(ofSize: 24)
        
        loader.centerInContainer()
    }
    
    private func loadData() {
        vm.execute(action: .ShowPokemonDetail(pokemon: pokemon))
    }
    
    private func showDetail(pokemon: Pokemon) {
        if let strongData = pokemon.dataImage {
            image.image = UIImage(data: strongData)
        }
        if let strongName = pokemon.name {
            titleName.text = strongName.capitalized
        }
        
        hideLoader()
    }
    
    private func showLoader() {
        loader.startAnimating()
    }
    
    private func hideLoader() {
        loader.stopAnimating()
    }
}
