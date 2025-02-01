//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

public protocol NetworkService {
    func request<T: Decodable>(_ apiRequest: APIRequest, responseType: T.Type) async throws(NetworkError) -> T
    func request(_ apiRequest: APIRequest) async throws(NetworkError) -> Data
}
