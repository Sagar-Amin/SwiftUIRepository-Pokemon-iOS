//
//  PokemonListRequest.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/16/25.
//

import Foundation

struct PokemonListRequest: Requestable {
    var parameters: [String : String]
    var path: String = "pokemon"
    var type: String = "GET"
    
}
