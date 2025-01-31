//
//  MessageView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI

struct MessageView: View {
    let icon: MessageViewIcon?
    let message: String
    let actions: [MessageViewAction]
    
    init(icon: MessageViewIcon? = .error, message: String, actions: [MessageViewAction] = []) {
        self.icon = icon
        self.message = message
        self.actions = actions
    }
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon.systemName)
                        .font(.system(size: 24))
                        .foregroundColor(icon.foregroundColor)
                }
                
                Text(message)
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            
            ForEach(actions, id: \.title) { action in
                Button(action: {
                    action.action?()
                }) {
                    Text(action.title)
                        .font(.headline)
                        .foregroundColor(Color(.systemBackground))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(.primary)
                        .cornerRadius(8)
                }
                .contentShape(Rectangle())
            }
        }
        .padding()
    }
}

#Preview {
    MessageView(message: "Something went wrong...", actions: [.close()])
}
