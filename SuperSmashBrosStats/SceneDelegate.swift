//
//  SceneDelegate.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

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
        guard let context = CoreDataManager.shared.context else { fatalError("Can't get context from core data") }
        let userDataModel = UserDataModel()
        let homeScreenNavigationController = self.homeScreenNavigationController(
            managedObjectContext: context,
            userDataModel: userDataModel)
        let settingsScreenNavigationController = self.settingsScreenNavigationController(
            managedObjectContext: context,
            userDataModel: userDataModel)
        let tabBarContoller = UITabBarController()
        let controllers = [homeScreenNavigationController, settingsScreenNavigationController]
        tabBarContoller.setViewControllers(controllers, animated: true)
        return tabBarContoller
    }

    // swiftlint:disable:next line_length
    func homeScreenNavigationController(managedObjectContext: NSManagedObjectContext, userDataModel: UserDataModel) -> UINavigationController {
        let viewModel = HomeScreenViewModel()
        let contentView = HomeScreenContentView(viewModel: viewModel)
            .environment(\.managedObjectContext, managedObjectContext)
            .environmentObject(userDataModel)
        let hostinController = UIHostingController(rootView: contentView)
        let navigationController = UINavigationController(rootViewController: hostinController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(
            title: Localizer.getLocalizableString(of: .STATS),
            image: UIImage(systemName: "s.circle"),
            tag: 0)
        return navigationController
    }

    // swiftlint:disable:next line_length
    func settingsScreenNavigationController(managedObjectContext: NSManagedObjectContext, userDataModel: UserDataModel) -> UINavigationController {
        let contentView = SettingsScreenContentView()
            .environment(\.managedObjectContext, managedObjectContext)
            .environmentObject(userDataModel)
        let hostinController = UIHostingController(rootView: contentView)
        let navigationController = UINavigationController(rootViewController: hostinController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(
            title: Localizer.getLocalizableString(of: .SETTINGS),
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
