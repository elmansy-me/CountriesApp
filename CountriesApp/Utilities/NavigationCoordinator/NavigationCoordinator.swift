//
//  NavigationCoordinator.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import UIKit
import SwiftUI

class NavigationCoordinator: NSObject, ObservableObject {
    private var navigationController: UINavigationController?

    func setRootView<T: View>(_ rootView: T) -> UINavigationController {
        let rootViewController = UIHostingController(rootView: rootView)
        let navController = UINavigationController(rootViewController: rootViewController)
        configureNavigationBarAppearance(navController)
        self.navigationController = navController
        return navController
    }

    func push<T: View>(_ view: T, animated: Bool = true) {
        guard let navigationController else { return }
        let viewController = UIHostingController(rootView: view)
        navigationController.pushViewController(viewController, animated: animated)
    }

    func present<T: View>(_ view: T, animated: Bool = true) {
        guard let navigationController else { return }
        let viewController = UIHostingController(rootView: view)
        navigationController.present(viewController, animated: animated)
    }

    func goBack(animated: Bool = true) {
        if let presentedVC = navigationController?.presentedViewController {
            presentedVC.dismiss(animated: animated)
        } else {
            navigationController?.popViewController(animated: animated)
        }
    }
    
    private func configureNavigationBarAppearance(_ navigationController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.tintColor = .black
    }
}
