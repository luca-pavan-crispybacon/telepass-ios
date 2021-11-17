//
//  PokemonApi.swift
//  telepass-ios
//
//  Created by Luca Pavan on 11/11/21.
//

import Foundation
import Alamofire

class PokemonApiImpl: PokemonApi {
    
    private var baseUrl = ""
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func getPokemonList(/*limit: Int = 100,*/ offset: Int, _ success: @escaping (PokemonListDto) -> Void, _ failure: @escaping (PokemonError) -> Void) {
        var url = URL(string: baseUrl + "/pokemon")!
        
        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var queryItems:[URLQueryItem] = []
        //queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))

        urlComponent.queryItems = queryItems
        url = urlComponent.url!
        
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
                    guard let parsedValue = try? JSONDecoder().decode(PokemonListDto.self, from: value) else {
                        DispatchQueue.main.async {
                            failure(PokemonError("Can't decode object"))
                        }
                        return
                    }
                    
                    guard parsedValue.results != nil else {
                        DispatchQueue.main.async {
                            failure(PokemonError("Empty list"))
                        }
                        return
                    }
                    
                    success(parsedValue)
                    if parsedValue.next == nil {
                        failure(PokemonError.asNoMoreData())
                    }
                    
                case let .failure(error):
                    DispatchQueue.main.async {
                        failure(PokemonError(error.localizedDescription))
                    }
                }
            }
    }
    
    func getPokemon(byName name: String, _ success: @escaping (PokemonDto) -> Void, _ failure: @escaping (PokemonError) -> Void) {
        let url = URL(string: baseUrl + "/pokemon/\(name)")!

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
                    guard let parsedValue = try? JSONDecoder().decode(PokemonDto.self, from: value) else {
                        DispatchQueue.main.async {
                            failure(PokemonError("Can't decode object"))
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        success(parsedValue)
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        failure(PokemonError(error.localizedDescription))
                    }
                }
            }
    }
}
