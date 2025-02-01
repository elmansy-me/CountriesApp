//
//  MessageViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import SwiftUI

class MessageViewModel: ObservableObject {
    
    let icon: MessageViewIcon?
    let message: String
    let actions: [MessageViewAction]
    
    init(icon: MessageViewIcon?, message: String, actions: [MessageViewAction]) {
        self.icon = icon
        self.message = message
        self.actions = actions
    }
    
    lazy var shouldShowIcon: Bool = {
        icon != nil
    }()
    
    lazy var iconSystemName: String = {
        switch icon {
        case .error:
            return "xmark.circle.fill"
        case .search:
            return "magnifyingglass"
        default:
            return ""
        }
    }()
    
    lazy var iconForegroundColor: Color = {
        switch icon {
        case .error:
            return .red
        case .search:
            return .secondary
        default:
            return .primary
        }
    }()
    
}
