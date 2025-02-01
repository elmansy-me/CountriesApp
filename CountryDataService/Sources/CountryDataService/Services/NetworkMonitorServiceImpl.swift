//
//  NetworkMonitorServiceImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import Reachability

class NetworkMonitorServiceImpl: NetworkMonitorService {
    private let reachability: Reachability?

    init() {
        reachability = try? Reachability()
    }

    func isConnected() async -> Bool {
        guard let reachability else {
            return false
        }
        
        try? reachability.startNotifier()

        let isConnected = await withCheckedContinuation { continuation in
            if reachability.connection == .unavailable {
                continuation.resume(returning: false)
            } else {
                continuation.resume(returning: true)
            }
        }
        reachability.stopNotifier()
        return isConnected
    }

}
