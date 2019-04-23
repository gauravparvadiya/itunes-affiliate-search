//
//  AppCoordinator.swift
//  iTunesAffiliate
//
//  Created by Gaurav Parvadiya on 2019-04-17.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator {
    var window: UIWindow
    let application: UIApplication
    
    init(window: UIWindow, application: UIApplication ) {
        self.window = window
        self.application = application
        super.init()
    }
    
    func start() {
        let vc  = StoryboardScene.Dashboard.dashboardViewController.instantiate()
        vc.viewModel = DashboardViewModel()
//        vc.viewModel?.coordinator = self
        show(viewController: UINavigationController(rootViewController: vc), window: &window, shouldNavigate: false)
    }
}
