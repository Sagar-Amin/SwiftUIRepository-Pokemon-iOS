//
//  ViewModel.swift
//  DigimonApp
//
//  Created by Sagar Amin on 3/4/25.
//

import Foundation
import Combine


enum State {
    case loading
    case loaded
    case error(Error)
    case empty
}
     

class PokemonViewModel : ObservableObject {
    
    
    @Published var pokemons = [Pokemon]()
    @Published var state: State = .empty
    
    private var repository: PokemenRepositoryActions
    init(repository: PokemenRepositoryActions) {
        self.repository = repository
    }
    
    // call api and get response via Model
    @MainActor
    func getList() async {
        state = .loading // inital status for calling api
        
        do {
            // call api and then get pokemon list
            pokemons = try await repository.fetchPokemons().results
            
            state = .loaded
            
        } catch {
            // if any errors
            state = .error(error)
            
            switch error {
                case is DecodingError:
                    state = .error(error)
                case is URLError:
                    state = .error(NetworkError.isValideURL)
                case NetworkError.isValideURL:
                    state = .error(NetworkError.invalidURLError)
                default:
                    break
            }
        }
            
    }
    
}
