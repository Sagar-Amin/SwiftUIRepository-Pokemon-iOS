//
//  Response.swift
//
//
//  Created by Sagar Amin on 3/4/25.
//

struct Pokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon] // results is pokemon list
}

extension Pokemon: Identifiable {
    var id: String {
        return name + url
    }
}
