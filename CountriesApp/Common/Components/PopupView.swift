//
//  PopupView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import SwiftUI

struct PopupView: View {
    
    let icon: MessageViewIcon?
    let message: String
    let actions: [MessageViewAction]
    
    init(icon: MessageViewIcon? = .error, message: String, actions: [MessageViewAction] = []) {
        self.icon = icon
        self.message = message
        self.actions = actions
    }
    
    var body: some View {
        VStack {
            Spacer()
            MessageView(icon: icon, message: message, actions: actions)
        }
    }
}
