//
//  NavigationContainerView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI

struct NavigationContainerView<T: View>: UIViewControllerRepresentable {
    let coordinator: NavigationCoordinator
    let rootView: T

    func makeUIViewController(context: Context) -> UINavigationController {
        return coordinator.setRootView(rootView)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
