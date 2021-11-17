//
//  PokemonError.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation

class PokemonError: Error {
    
    private(set) var message = ""
    
    private(set) var code: ErrorCode = .GENERIC
    
    private(set) var isSilent = false
    
    init(_ errorMessage: String = "", isSilent: Bool = false) {
        message = errorMessage
        self.isSilent = isSilent
    }
    
    static func asNoData() -> PokemonError {
        let error = PokemonError(isSilent: true)
        error.code = .NO_DATA
        return error
    }
    
    static func asNoMoreData() -> PokemonError {
        let error = PokemonError(isSilent: true)
        error.code = .NO_MORE_DATA
        return error
    }
    
    static func asInvalidUrl() -> PokemonError {
        let error = PokemonError(isSilent: true)
        error.code = .INVALID_URL
        return error
    }
}

enum ErrorCode: Hashable {
    case GENERIC
    case NO_DATA
    case NO_MORE_DATA
    case INVALID_URL
}
