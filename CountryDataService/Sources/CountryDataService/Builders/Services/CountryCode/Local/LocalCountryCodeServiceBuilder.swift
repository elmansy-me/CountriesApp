//
//  LocalCountryCodeServiceBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

final class LocalCountryCodeServiceBuilder {
    static func build() -> LocalCountryCodeService {
        let service = LocalCountryCodeServiceImpl()
        return service
    }
}
