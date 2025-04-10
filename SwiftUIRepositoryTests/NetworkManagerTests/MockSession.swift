//
//  MockSession.swift
//  SwiftUIRepository
//
//  Created by Sagar Amin on 3/16/25.
//

import Foundation
@testable import SwiftUIRepository

class MockSession: NetworkSessionable {
    
    private var error: Error?
    private var data: Data?
    private var urlResponse: URLResponse?
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        
        if error != nil {
            throw self.error!
        }
        return (self.data!, self.urlResponse!)
    }
    
    func setError(error: Error) {
        self.error = error
    }
    func setUrlResponse(urlResponse: URLResponse) {
        self.urlResponse = urlResponse
    }
    func setData(data: Data) {
        self.data = data
    }
}
