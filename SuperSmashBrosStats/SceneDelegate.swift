//
//  SceneDelegate.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = homeScreenViewController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func homeScreenViewController() -> UIViewController {
        let viewModel = HomeScreenViewModel()
        let contentView = HomeScreenContentView(viewModel: viewModel)
            .environment(\.managedObjectContext, CoreDataManager.shared.context!)
        let hostinController = UIHostingController(rootView: contentView)
        let navigationController = UINavigationController(rootViewController: hostinController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}
