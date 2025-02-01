//
//  RemoteCountryServiceBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import NetworkLayer

final class RemoteCountryServiceBuilder {
    static public func build() -> RemoteCountryService {
        let networkService = NetworkServiceBuilder.build()
        let service = RemoteCountryServiceImpl(networkService: networkService)
        return service
    }
}
