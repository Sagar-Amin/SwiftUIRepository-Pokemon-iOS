//
//  ContentView.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/12/25.
//

import SwiftUI

struct PokemonView: View {
    
    @StateObject var viewModel = PokemonViewModel(repository: PokemonRepository(networkManager: NetworkManager()))
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(LocalizedStringKey("title"))
                    .font(.title)
                
                switch viewModel.state {
                case .loading:  // 2nd step
                    ProgressView().frame(width: 100, height: 100)
                    
                case .loaded:    // final step
                    displayList()
                    
                case .error(let error):   // except
                    displayError(error: error)
                    
                case .empty:   // 1st step
                    displayInit()
                    
                }
            }
            .navigationTitle("POKEMON")
            .task {
                await viewModel.getList()
            }
            .refreshable {
                await viewModel.getList()
            }
        }
        
    }
    
    @ViewBuilder
    func displayError(error: Error) -> some View {
        Text("Error: \(error.localizedDescription)")
            .font(.headline)
    }
    
    @ViewBuilder
    func displayList() -> some View {
        List(viewModel.pokemons) { pokemon in
            NavigationLink {
                EmptyView()
            } label: {
                VStack(alignment: .leading) {
                    Text(pokemon.name.capitalized)
                        .font(.title)
                    Text(pokemon.url)
                        .font(.caption)
                }
               
            }
        }
        .listStyle(.grouped)
    }
    
    @ViewBuilder
    func displayInit() -> some View {
        Image(systemName: "bird.circle.fill")
            .resizable()
            .frame(width: 200, height: 200)
            .foregroundStyle(.red)
        
        Text("Welcome to Pokemon App!")
            .font(.headline)
    }
}

#Preview {
    PokemonView()
}
