//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

public class NetworkService {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request<T: Decodable>(_ apiRequest: APIRequest, responseType: T.Type) async throws -> T {
        let data = try await fetchData(apiRequest)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    public func request(_ apiRequest: APIRequest) async throws -> Data {
        return try await fetchData(apiRequest)
    }
    
    private func fetchData(_ apiRequest: APIRequest) async throws -> Data {
        let request = try apiRequest.buildURLRequest()
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                    throw NetworkError.apiError(apiError)
                } else {
                    throw NetworkError.statusCode(httpResponse.statusCode)
                }
            }
            
            return data
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
