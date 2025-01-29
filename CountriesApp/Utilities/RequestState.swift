//
//  RequestState.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

enum RequestState<T> {
    case loading
    case success(T)
    case failure(String)
}
