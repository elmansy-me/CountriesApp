//
//  NetworkMonitorServiceBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

final class NetworkMonitorServiceBuilder {
    static public func build() -> NetworkMonitorService {
        NetworkMonitorServiceImpl()
    }
}
