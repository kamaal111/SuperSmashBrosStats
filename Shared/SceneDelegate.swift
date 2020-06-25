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
            guard let context = CoreDataManager.shared.context else { fatalError("Can't get context from core data") }
            let userDataModel = UserDataModel()
            let contentView = ContentView()
                .environment(\.managedObjectContext, context)
                .environmentObject(userDataModel)
            window.rootViewController = UIHostingController(rootView: contentView)
            window.tintColor = .getAppColor(from: LocalStorageHelper.getString(from: .appColor))
            self.window = window
            window.makeKeyAndVisible()
        }
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
