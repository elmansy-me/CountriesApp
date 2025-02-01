//
//  NetworkServiceBuilder.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

public final class NetworkServiceBuilder {
    static public func build() -> NetworkService {
        return NetworkServiceImpl(session: .shared)
    }
}
