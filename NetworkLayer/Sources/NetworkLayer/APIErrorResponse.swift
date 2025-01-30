//
//  APIErrorResponse.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation

struct APIErrorResponse: Decodable {
    let status: Int
    let message: String
}
