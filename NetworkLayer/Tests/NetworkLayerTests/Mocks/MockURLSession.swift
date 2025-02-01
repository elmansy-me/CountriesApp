//
//  File.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

class MockURLSession {
    let session: URLSession
    
    init(urlProtocol: URLProtocol) {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        self.session = session
    }
}
