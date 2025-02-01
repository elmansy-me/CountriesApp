//
//  NetworkServiceImpl.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

class NetworkServiceImpl: NetworkService {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(_ apiRequest: APIRequest, responseType: T.Type) async throws(NetworkError) -> T {
        let data = try await fetchData(apiRequest)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw .decodingError(error)
        }
    }
    
    public func request(_ apiRequest: APIRequest) async throws(NetworkError) -> Data {
        return try await fetchData(apiRequest)
    }
    
    private func fetchData(_ apiRequest: APIRequest) async throws(NetworkError) -> Data {
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
        } catch let error as NetworkError {
            throw error
        } catch let error as URLError {
            throw .statusCode(error.code.rawValue)
        } catch let error as DecodingError {
            throw .decodingError(error)
        } catch {
            throw .unknown(error)
        }
    }
}
