//
//  LoginRootView.swift
//  mojn
//
//  Created by Kasper Kronborg on 28/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless

public class LoginRootView: View, RootView {
    public lazy var emailTextField: TextField = {
        let textField = TextField(style: Stylesheet.textField)
        textField.placeholder = "Email"
        return textField
    }()
    
    public lazy var passwordTextField: TextField = {
        let textField = TextField(style: Stylesheet.textField)
        textField.placeholder = "Password"
        return textField
    }()
    
    override public var subviewsLayout: AnyLayout {
        return stack(.vertical)(
            emailTextField.sizing(toWidth: 200, height: 45),
            passwordTextField.sizing(toWidth: 200, height: 45)
        ).centeringInParent()
    }
}

public extension LoginRootView {
    enum Stylesheet {        
        static let textField = Style<TextField> {
            $0.textColor = .green
            $0.backgroundColor = .blue
        }
    }
}
