//
//  Pokemon.swift
//  telepass-ios
//
//  Created by Luca Pavan on 11/11/21.
//

import Foundation

struct Pokemon: Hashable {
    let id: Int?
    let name: String?
    let abilities: [Ability]?
    let moves: [Move]?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    var dataImage: Data? = nil
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        guard let strongLeftId = lhs.id else { return false }
        guard let strongRightId = rhs.id else { return false }
        return strongLeftId == strongRightId
    }
}

// MARK: - Ability
struct Ability: Hashable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?
}

// MARK: - Species
struct Species: Hashable {
    let name: String?
    let url: String?
}

// MARK: - Move
struct Move: Hashable {
    let move: Species?
}

// MARK: - Sprites
struct Sprites: Hashable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
}

// MARK: - Stat
struct Stat: Hashable {
    let baseStat, effort: Int?
    let stat: Species?
}

// MARK: - TypeElement
struct TypeElement: Hashable {
    let slot: Int?
    let type: Species?
}
