//
//  FakeNetworkManager.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/16/25.
//

import Foundation
@testable import SwiftUIRepository


class FakeNetworkManager: APIService {
    var testPath = ""
    
    func fetchData<T: Decodable>(urlRequest: Requestable,
            modelType: T.Type
    ) async throws -> T where T: Decodable {
        guard !testPath.isEmpty else {
            throw NetworkError.invalidURLError
        }
        
        let bundle = Bundle(for: FakeNetworkManager.self)
        
        guard let url = bundle.url(forResource: testPath, withExtension: "json") else {
            throw NetworkError.invalidURLError
        }
        
        do  {
            let fileData = try Data(contentsOf: url)
            let parseData = try JSONDecoder().decode(modelType, from: fileData)
            return parseData
        } catch {
            throw error
        }
    }
}
