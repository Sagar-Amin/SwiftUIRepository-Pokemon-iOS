//
//  PokemonViewModelTests.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/16/25.
//

import XCTest
@testable import SwiftUIRepository

final class PokemonViewModelTests: XCTestCase {
    
    var viewModel: PokemonViewModel!
    var respository: StubPokemonRepository!
    
    override func setUpWithError() throws {
    
    }
    
    override func tearDownWithError() throws {
        
    }
    
    
    func testGetPokemonList_WhenWeExpectCorrectBehaviour() async throws {
        respository = StubPokemonRepository()
        viewModel = PokemonViewModel(repository: respository)
        
        respository.setResponse(response: PokemonResponse(count: 100, next: "someURL", previous: nil,
                                                          results: [Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/1")]))
        
        await viewModel.getList()
        
        XCTAssertEqual(viewModel.pokemons.count, 1)
        
        let pokemon = viewModel.pokemons[0]
        XCTAssertEqual(pokemon.name, "bulbasaur")
        XCTAssertEqual(pokemon.url, "https://pokeapi.co/api/v2/pokemon/1/1")
        
    }
}
