//
//  SceneDelegate.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 21.06.2023.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var flowCoordinator = FlowCoordinator(window: window!)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        flowCoordinator.showRootView()
        window?.makeKeyAndVisible()
    }
}
