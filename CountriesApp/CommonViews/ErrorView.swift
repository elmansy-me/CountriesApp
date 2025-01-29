//
//  ErrorView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 8) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.red)
                
                Text(errorMessage)
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
    ErrorView(errorMessage: "Something went wrong...", retryAction: {})
}
