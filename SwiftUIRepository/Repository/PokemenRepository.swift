//
//  PokemenRepository.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/12/25.
//

import Foundation

protocol PokemenRepositoryActions {
    func fetchPokemons() async throws -> PokemonResponse
}

class PokemonRepository {
    var apiManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.apiManager = networkManager
    }
}

extension PokemonRepository: PokemenRepositoryActions {
    func fetchPokemons() async throws -> PokemonResponse {
//        guard let url = URL(string: APIEndpoint.baseURL + APIEndpoint.endPoint) else {
//            throw NetworkError.isValideURL
//        }
        do {
            // call api with customized parameters, instead calling api url directly
            let params = ["limit": "40", "offset": "0"]
            let pokemonListRequest = PokemonListRequest(parameters: params, path: APIEndpoint.endPoint, type: "GET")
            let response = try await apiManager.fetchData(urlRequest: pokemonListRequest, modelType: PokemonResponse.self)
            
            return response
        } catch {
            throw error
        }
        
    }
}
