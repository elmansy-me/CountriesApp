//
//  CountriesAppApp.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI
import CountryDataService

@main
struct CountriesAppApp: App {
    
    private let appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            appCoordinator.start()
        }
    }
}
