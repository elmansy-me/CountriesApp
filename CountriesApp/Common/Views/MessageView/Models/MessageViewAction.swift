//
//  MessageViewAction.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

struct MessageViewAction {
    let title: String
    let action: (() -> Void)?
}


extension MessageViewAction {
    static func close(action: (() -> Void)? = nil) -> MessageViewAction {
        return .init(title: "Close", action: action)
    }
    
    static func retry(action: (() -> Void)? = nil) -> MessageViewAction {
        return .init(title: "Retry", action: action)
    }
}
