//
//  NetworkManagerTests.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/16/25.
//

import XCTest
@testable import SwiftUIRepository

final class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var mockSession: MockSession!
    
    override func setUpWithError() throws {
        networkManager = NetworkManager()
        mockSession = MockSession()
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testfetchData_WhenExpectingCorrectResults() async throws {
        
        let dommyData = """
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40",
          "previous": null,
          "results": [
            {
              "name": "bulbasaur",
              "url": "https://pokeapi.co/api/v2/pokemon/1/"
            },
            {
              "name": "ivysaur",
              "url": "https://pokeapi.co/api/v2/pokemon/2/"
            }
           ]
        }
        """.data(using: .utf8)!
        mockSession.setData(data: dommyData)
        
        let mockURLResponse = HTTPURLResponse(url: URL(string: "https://api.test")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockSession.setUrlResponse(urlResponse: mockURLResponse)
        
        
        Task {
            let request = PokemonListRequest(parameters: [:], path: APIEndpoint.endPoint, type: "Get")
            let pokemonResponse = try await networkManager.fetchData(urlRequest: request, modelType: PokemonResponse.self)
            XCTAssertNotNil(pokemonResponse)
            
            XCTAssertEqual(pokemonResponse.results.count, 2)
            
            let pokemon = pokemonResponse.results[0]
            XCTAssertEqual(pokemon.name, "bulbasaur")
            XCTAssertEqual(pokemon.url, "https://pokeapi.co/api/v2/pokemon/1/")
            XCTAssertEqual(pokemonResponse.count, 1302)
            XCTAssertEqual(pokemonResponse.next, "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40")
            XCTAssertNil(pokemonResponse.previous)
        
        }
        
        
    }
    
    func testfetchData_WhenExpecting404Error() async throws {
        
        let dommyData = """
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40",
          "previous": null,
          "results": [
            {
              "name": "bulbasaur",
              "url": "https://pokeapi.co/api/v2/pokemon/1/"
            },
            {
              "name": "ivysaur",
              "url": "https://pokeapi.co/api/v2/pokemon/2/"
            }
           ]
        }
        """.data(using: .utf8)!
        mockSession.setData(data: dommyData)
        
        let mockURLResponse = HTTPURLResponse(url: URL(string: "https://api.test")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        mockSession.setUrlResponse(urlResponse: mockURLResponse)
        
        
        Task {
            let request = PokemonListRequest(parameters: [:], path: APIEndpoint.endPoint, type: "Get")
            
            do {
                let pokemonResponse = try await networkManager.fetchData(urlRequest: request, modelType: PokemonResponse.self)
                XCTAssertNil(pokemonResponse)
            }
            catch {
                XCTAssertNotNil(error)
                
            }
            
        }
        
        
    }
    
    
    func testfetchData_WhenRequestIsInvalidAndExpectionInvalidRequestError() async throws {
        
        let dommyData = """
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=40&limit=40",
          "previous": null,
          "results": [
            {
              "name": "bulbasaur",
              "url": "https://pokeapi.co/api/v2/pokemon/1/"
            },
            {
              "name": "ivysaur",
              "url": "https://pokeapi.co/api/v2/pokemon/2/"
            }
           ]
        }
        """.data(using: .utf8)!
        mockSession.setData(data: dommyData)
        
        let mockURLResponse = HTTPURLResponse(url: URL(string: "https://api.test")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockSession.setUrlResponse(urlResponse: mockURLResponse)
        
        
        Task {
            let request = PokemonListRequest(parameters: [:], path: "", type: "Get")
            
            do {
                let pokemonResponse = try await networkManager.fetchData(urlRequest: request, modelType: PokemonResponse.self)
                XCTAssertNil(pokemonResponse)
            }
            catch {
                XCTAssertNotNil(error)
            }
            
        }
    }
    
}
