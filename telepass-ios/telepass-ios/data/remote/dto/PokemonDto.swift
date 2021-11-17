//
//  PokemonDto.swift
//  telepass-ios
//
//  Created by Luca Pavan on 11/11/21.
//

import Foundation

public struct PokemonDto: Codable {
    
    let id: Int?
    let name: String?
    let abilities: [AbilityDto]?
    let moves: [MoveDto]?
    let sprites: SpritesDto?
    let stats: [StatDto]?
    let types: [TypeElementDto]?
    
    func toPokemon() -> Pokemon {
        return Pokemon(
            id: id,
            name: name,
            abilities: abilities?.map { $0.toAbility() },
            moves: moves?.map { $0.toMove() },
            sprites: sprites?.toSprites(),
            stats: stats?.map { $0.toStat() },
            types: types?.map { $0.toTypeElement() }
        )
    }
}

// MARK: - Ability
struct AbilityDto: Codable {
    let ability: SpeciesDto?
    let isHidden: Bool?
    let slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
    
    func toAbility() -> Ability {
        return Ability(
            ability: ability?.toSpecies(),
            isHidden: isHidden,
            slot: slot
        )
    }
}

// MARK: - Species
struct SpeciesDto: Codable {
    let name: String?
    let url: String?
    
    func toSpecies() -> Species {
        return Species(name: name, url: url)
    }
}

// MARK: - Move
struct MoveDto: Codable {
    let move: SpeciesDto?
    
    func toMove() -> Move {
        return Move(move: move?.toSpecies())
    }
}

// MARK: - Sprites
struct SpritesDto: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
    
    func toSprites() -> Sprites {
        return Sprites(
            backDefault: backDefault,
            backFemale: backFemale,
            backShiny: backShiny,
            backShinyFemale: backShinyFemale,
            frontDefault: frontDefault,
            frontFemale: frontFemale,
            frontShiny: frontShiny,
            frontShinyFemale: frontShinyFemale
        )
    }
}

// MARK: - Stat
struct StatDto: Codable {
    let baseStat, effort: Int?
    let stat: SpeciesDto?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
    
    func toStat() -> Stat {
        return Stat(baseStat: baseStat, effort: effort, stat: stat?.toSpecies())
    }
}

// MARK: - TypeElement
struct TypeElementDto: Codable {
    let slot: Int?
    let type: SpeciesDto?
    
    func toTypeElement() -> TypeElement {
        return TypeElement(slot: slot, type: type?.toSpecies())
    }
}
