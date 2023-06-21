//
//  GameCoordinator.swift
//  GreenThumbsDivider
//
//  Created by Павло Сніжко on 21.06.2023.
//

import UIKit
import SwiftUI

class GameCoordinator: Coordinator {
    let teamsViewModel: TeamsViewModel
    let rootViewCotnroller: UINavigationController
    
    init(teamsViewModel: TeamsViewModel, rootViewCotnroller: UINavigationController) {
        self.teamsViewModel = teamsViewModel
        self.rootViewCotnroller = rootViewCotnroller
    }
    
    func start() {
        let teamView = TeamsView(vm: teamsViewModel)
        
        let vc = UIHostingController(rootView: teamView)
        rootViewCotnroller.pushViewController(vc, animated: true)
    }

}
