//
//  ViewController.swift
//  mojn
//
//  Created by Casper Rogild Storm on 19/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import UIKit
import Siesta
import Layoutless

class RootViewController: ViewController {
    let tabBarCnt = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBarController()
    }
    
    func createTabBarController() {
        let vc1 = PseudosViewController()
        vc1.tabBarItem = UITabBarItem.init(tabBarSystemItem: .bookmarks, tag: 0)
        
        let vc2 = UIViewController()
        vc2.tabBarItem = UITabBarItem.init(tabBarSystemItem: .featured, tag: 0)

        tabBarCnt.viewControllers = [vc1, vc2].map{ UINavigationController.init(rootViewController: $0)}
        
        self.view.addSubview(tabBarCnt.view)
    }
}


