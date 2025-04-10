//
//  PokemonRepositoryTests.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/16/25.
//

import XCTest
@testable import SwiftUIRepository

class PokemonRepositoryTests : XCTestCase {
    
    var repository: PokemonRepository!
    var fakemanager: FakeNetworkManager!
    
    
    override func setUpWithError() throws {
        fakemanager = FakeNetworkManager()
        
    }
    
    override func tearDownWithError() throws {
        fakemanager = nil
        repository = nil
    }
    
}
