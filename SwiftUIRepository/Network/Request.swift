//
//  Requestable.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/16/25.
//

import Foundation

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
    var type: String { get }
    
    func createURLRequest() throws -> URLRequest?
    
}

protocol RequestVariable {
    var path: String { get }
    var parameters: [String: String] { get }
    var type: String { get }
}

extension Requestable {
    var baseURL: String {
        return APIEndpoint.baseURL
    }
    var headers: [String: String] {
        return [:]
    }
    var parameters: [String: String] {
        return [:]
    }
    func createURLRequest() throws -> URLRequest? {
        
        guard baseURL.count > 0, path.count > 0 else {
            return nil
        }
        
        var components = URLComponents(string: baseURL + path)
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        components?.queryItems = queryItems
            
        guard let url = components?.url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
}
