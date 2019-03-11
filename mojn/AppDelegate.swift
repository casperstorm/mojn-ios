//
//  AppDelegate.swift
//  mojn
//
//  Created by Casper Rogild Storm on 19/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
//        let loginViewController = LoginViewController(viewModel: LoginViewModel())
//        self.window?.rootViewController = MessageViewController()
        let nc = UINavigationController(rootViewController: PseudosViewController(viewModel: PseudosViewModel()))
        self.window?.rootViewController = nc

        
        return true
    }
}

