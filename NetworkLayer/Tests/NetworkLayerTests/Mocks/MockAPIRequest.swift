//
//  File.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
@testable import NetworkLayer

struct MockAPIRequest: APIRequest {
    var scheme: URLScheme = .http
    var host: String = ""
    var path: String = ""
    var method: HTTPMethod = .GET
    var headers: [String : String]? = nil
    var body: Data? = nil
    var queryParameters: [String : String]? = nil
}
