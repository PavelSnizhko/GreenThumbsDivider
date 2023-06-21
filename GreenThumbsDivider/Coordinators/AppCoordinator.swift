//
//  AppCoordinator.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 21.06.2023.
//

import UIKit
import SwiftUI

final class FlowCoordinator: ObservableObject, Coordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showRootView() {
        let persistenceController = PersistenceController.shared
        let vm = PlayerViewModel(context: persistenceController.container.viewContext)
        let navigationViewController = UINavigationController()
        
        let rootView = MainView(playerViewModel: vm, playFlow: { vm in
            let coordinator = GameCoordinator(teamsViewModel: vm, rootViewCotnroller: navigationViewController)
            coordinator.start()
        }).environment(\.managedObjectContext, persistenceController.container.viewContext)
        
        let hostingView = UIHostingController(rootView: rootView)
        
        navigationViewController.viewControllers = [hostingView]
        window.rootViewController = navigationViewController
    }
    
    func start() {
        showRootView()
    }
    
}
