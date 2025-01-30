//
//  CountryNameRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import NetworkLayer

public final class CountryNameRepositoryBuilder {
    static public func build() -> CountryNameRepository {
        let networkService = NetworkService()
        let remoteService = RemoteCountryNameService(networkService: networkService)
        let userLocationService = UserLocationServiceImpl()
        let repository = CountryNameRepositoryImpl(remoteService: remoteService, userLocationService: userLocationService)
        return repository
    }
}
