//
//  MessageView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI

struct MessageView: View {
    let icon: MessageViewIcon
    let message: String
    let retryAction: (() -> Void)?
    
    init(icon: MessageViewIcon = .error, message: String, retryAction: (() -> Void)? = nil) {
        self.icon = icon
        self.message = message
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                Image(systemName: icon.systemName)
                    .font(.system(size: 24))
                    .foregroundColor(icon.foregroundColor)
                
                Text(message)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            
            if let retryAction {
                Button(action: retryAction) {
                    Text("Retry")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .contentShape(Rectangle())
            }
        }
        .padding()
    }
}

#Preview {
    MessageView(message: "Something went wrong...", retryAction: {})
}
