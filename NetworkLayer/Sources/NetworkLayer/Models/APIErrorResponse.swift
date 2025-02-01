//
//  APIErrorResponse.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation

public struct APIErrorResponse: Codable, Sendable {
    public let status: Int
    public let message: String
}
