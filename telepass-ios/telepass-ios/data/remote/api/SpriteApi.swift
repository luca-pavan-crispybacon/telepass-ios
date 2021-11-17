//
//  SpriteApi.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation
import Alamofire

protocol SpriteApi {
    
    func getPokemonPic(byId id: Int, _ success: @escaping (Data) -> Void, _ failure: @escaping (PokemonError) -> Void)
}
