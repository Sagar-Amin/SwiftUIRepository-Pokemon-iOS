//
//  StubPokemonRepository.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/16/25.
//

import Foundation
@testable import SwiftUIRepository

class StubPokemonRepository: PokemenRepositoryActions {
    
    private var error: NetworkError?
    private var pokemonResponse: PokemonResponse?
    
    func fetchPokemons() async throws -> SwiftUIRepository.PokemonResponse {
        if error != nil {
            throw error!
        }
        return pokemonResponse!
    }
    
    func setError(error: NetworkError) {
        self.error = error
    }
    func setResponse(response: PokemonResponse) {
        self.pokemonResponse = response
    }
    
}
