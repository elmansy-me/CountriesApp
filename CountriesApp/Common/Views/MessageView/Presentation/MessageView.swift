//
//  MessageView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI

struct MessageView: View {

    @ObservedObject var viewModel: MessageViewModel
    
    init(icon: MessageViewIcon? = .error, message: String, actions: [MessageViewAction] = []) {
        self.viewModel = MessageViewModel(icon: icon, message: message, actions: actions)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                if viewModel.shouldShowIcon {
                    Image(systemName: viewModel.iconSystemName)
                        .font(.system(size: 24))
                        .foregroundColor(viewModel.iconForegroundColor)
                }
                
                Text(viewModel.message)
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            
            ForEach(viewModel.actions, id: \.title) { action in
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
