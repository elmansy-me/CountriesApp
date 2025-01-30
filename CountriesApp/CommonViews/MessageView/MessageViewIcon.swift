//
//  MessageViewIcon.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI

enum MessageViewIcon {
    case error
    case search
    
    var systemName: String {
        switch self {
        case .error:
            return "xmark.circle.fill"
        case .search:
            return "magnifyingglass"
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .error:
            return .red
        case .search:
            return .gray
        }
    }
}
