//
//  UserDefaultsDatabaseBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import DatabaseKit

final class UserDefaultsDatabaseBuilder {
    static func build() -> DatabaseService {
        let service = UserDefaultsDatabase()
        return service
    }
}
