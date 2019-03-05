//
//  LoginViewController.swift
//  mojn
//
//  Created by Kasper Kronborg on 28/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Layoutless

public class LoginViewController: GenericViewController<LoginViewModel, LoginRootView> {
    public override func viewDidLoad() {
        self.rootView.apply(Stylesheet.root)
    }
}

public extension LoginViewController {
    enum Stylesheet {
        static let root = Style<View> {
            $0.backgroundColor = .red
        }
    }
}

