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

    // swiftlint:disable:next line_length
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = self.tabBarController()
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func tabBarController() -> UITabBarController {
        let userDataModel = UserDataModel()
        let homeScreenViewController = self.homeScreenViewController(userDataModel: userDataModel)
        let settingsScreenViewController = self.settingsScreenViewController(userDataModel: userDataModel)
        let tabBarContoller = UITabBarController()
        tabBarContoller.setViewControllers([homeScreenViewController, settingsScreenViewController], animated: true)
        return tabBarContoller
    }

    func homeScreenViewController(userDataModel: UserDataModel) -> UINavigationController {
        let viewModel = HomeScreenViewModel()
        let contentView = HomeScreenContentView(viewModel: viewModel)
            .environment(\.managedObjectContext, CoreDataManager.shared.context!)
            .environmentObject(userDataModel)
        let hostinController = UIHostingController(rootView: contentView)
        let navigationController = UINavigationController(rootViewController: hostinController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(
            title: "Stats",
            image: UIImage(systemName: "s.circle"),
            tag: 0)
        return navigationController
    }

    func settingsScreenViewController(userDataModel: UserDataModel) -> UINavigationController {
        let contentView = SettingsScreenContentView()
            .environmentObject(userDataModel)
        let hostinController = UIHostingController(rootView: contentView)
        let navigationController = UINavigationController(rootViewController: hostinController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "ellipsis"),
            tag: 1)
        return navigationController
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) {
        do {
            try CoreDataManager.shared.save()
        } catch {
            print("Could not save when entering background", error)
        }
    }

}
