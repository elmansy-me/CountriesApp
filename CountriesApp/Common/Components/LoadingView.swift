//
//  LoadingView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 16) {
            Circle()
                .trim(from: 0.2, to: 1)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [.blue, .cyan, .blue]), center: .center),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)

            Text("Loading...")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .padding(20)
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    LoadingView()
}
