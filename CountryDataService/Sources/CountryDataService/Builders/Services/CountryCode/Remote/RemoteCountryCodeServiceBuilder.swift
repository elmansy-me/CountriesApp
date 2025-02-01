//
//  File.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import NetworkLayer

final class RemoteCountryCodeServiceBuilder {
    static public func build() -> RemoteCountryCodeService {
        let networkService = NetworkServiceBuilder.build()
        let service = RemoteCountryCodeServiceImpl(networkService: networkService)
        return service
    }
}
