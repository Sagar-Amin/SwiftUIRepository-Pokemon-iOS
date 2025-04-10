//
//  NetworkSessionable.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/16/25.
//

import Foundation

protocol NetworkSessionable {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSessionable {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        do {
            return try await self.data(for: request)
        }
        catch {
            throw error
        }
    }
}
