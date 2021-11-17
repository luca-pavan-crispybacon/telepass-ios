//
//  PokemonCell.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation
import UIKit
import Stevia

class PokemonCell: UICollectionViewCell {
    
    public static let TAG = "PokemonCell"
    
    public var representedIdentifier: Int? = nil
    
    private let imageView = UIImageView()
    private let titleName = UILabel()
    
    private let padding = 10
    
    func bind(_ pokemon: Pokemon? ) {
        guard let strongPokemon = pokemon else { return }
        backgroundColor = .white
        layer.masksToBounds = false
        
        if let strongImageData = strongPokemon.dataImage {
            setImage(UIImage(data: strongImageData))
        }
        
        titleName.font = UIFont.systemFont(ofSize: 16)
        titleName.text = strongPokemon.name
        titleName.backgroundColor = backgroundColor
        
        contentView.subviews(
            imageView,
            titleName
        )
        
        imageView.fillContainer(padding: padding)
        
        titleName.fillHorizontally(padding: padding)
        titleName.Bottom == contentView.Bottom - padding
        
        roundCorners(corners: [
            CACornerMask.layerMinXMinYCorner,
            CACornerMask.layerMinXMaxYCorner,
            CACornerMask.layerMaxXMinYCorner,
            CACornerMask.layerMaxXMaxYCorner
        ], radius: 20)
        
        elevate(elevation: 4)
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
}
