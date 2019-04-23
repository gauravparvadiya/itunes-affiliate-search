//
//  UIWindow+PresentedViewController.swift
//  iTunesAffiliate
//
//  Created by Gaurav Parvadiya on 2019-04-17.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(rootViewController)
        }
        return nil
    }
    
    class func getVisibleViewControllerFrom(_ viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return UIWindow.getVisibleViewControllerFrom(visibleViewController)
        }
        else if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return UIWindow.getVisibleViewControllerFrom(selectedViewController)
        }
        
        if let presentedViewController = viewController.presentedViewController,
            let presented = presentedViewController.presentedViewController {
            return UIWindow.getVisibleViewControllerFrom(presented)
        }
        else {
            return viewController
        }
    }
    
    func getVisibleNavigationController() -> UIViewController? {
        if let rootViewController = self.rootViewController {
            return UIWindow.getNavigationController(from: rootViewController)
        }
        return nil
    }
    
    class func getNavigationController(from viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        } else {
            return viewController
        }
    }
}


