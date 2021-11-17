//
//  SpriteApiImpl.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation
import Alamofire

class SpriteApiImpl: SpriteApi {
    
    private var baseUrl = ""
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getPokemonPic(byId id: Int, _ success: @escaping (Data) -> Void, _ failure: @escaping (PokemonError) -> Void) {
        let url = URL(string: baseUrl + "/pokemon/\(id).png")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        let encoding: ParameterEncoding = URLEncoding.default
        
        guard let url = try? encoding.encode(urlRequest, with: nil) else {
            failure(PokemonError.asInvalidUrl())
            return
        }
        AF.request(url)
            .validate()
            .responseData { data in
                switch data.result {
                case let .success(value):
                    DispatchQueue.main.async {
                        success(value)
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        failure(PokemonError(error.localizedDescription))
                    }
                }
            }
    }
}
