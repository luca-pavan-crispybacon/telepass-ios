//
//  PokemonDto.swift
//  telepass-ios
//
//  Created by Luca Pavan on 11/11/21.
//

import Foundation

public struct PokemonListDto: Codable {
    let count: Int64?
    let next: String?
    let previous: String?
    let results: [NamedAPIResourceDto]?
}
