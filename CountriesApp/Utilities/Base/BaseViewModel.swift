//
//  BaseViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

class BaseViewModel: ObservableObject {
    
    var coordinator: NavigationCoordinator?
    
    func provideCoordinator(_ coordinator: NavigationCoordinator) {
        self.coordinator = coordinator
    }
    
}
