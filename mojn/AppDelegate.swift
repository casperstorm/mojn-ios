//
//  AppDelegate.swift
//  mojn
//
//  Created by Casper Rogild Storm on 19/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        // Global app styling
        setupApplicationStyling()
        
        // TEMP: Login
        let keychain = Keychain(identifier: .credentials)
        if let sid = keychain.get(.sid), let token = keychain.get(.token) {
            MojnAPI.sharedInstance.login(sid: sid, token: token)
            print("logged in.")
        }
        
//        let loginViewController = LoginViewController(viewModel: LoginViewModel())
//        self.window?.rootViewController = MessageViewController()
        let nc = UINavigationController(rootViewController: PseudoCollectionViewController(viewModel: PseudoCollectionViewModel()))
        self.window?.rootViewController = nc
        
//        realm db file path
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
                
        return true
    }
}

extension AppDelegate {
    func setupApplicationStyling () {
        UINavigationBar.setupGlobalAppearance()
        UIBarButtonItem.setupGlobalAppearance()
    }
}

