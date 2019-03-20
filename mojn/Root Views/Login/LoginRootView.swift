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
    public lazy var sidTextField: TextField = {
        let textField = TextField(style: Stylesheet.textField)
        textField.placeholder = "SID"
        return textField
    }()
    
    public lazy var tokenTextField: TextField = {
        let textField = TextField(style: Stylesheet.textField)
        textField.placeholder = "Token"
        return textField
    }()
    
    public lazy var submitButton: Button = {
        let btn = Button(style: Stylesheet.button)
        btn.setTitle("Login", for: .normal)
        return btn
    }()
    
    override public var subviewsLayout: AnyLayout {
        return stack(.vertical)(
            sidTextField.sizing(toWidth: 200, height: 45),
            View(style: Stylesheet.separator).sizing(toWidth: 200, height: 0.5),
            tokenTextField.sizing(toWidth: 200, height: 45),
            View(style: Stylesheet.separator).sizing(toWidth: 200, height: 0.5),
            submitButton.sizing(toWidth: 200, height: 45)
        ).centeringInParent()
    }
}

public extension LoginRootView {
    enum Stylesheet {        
        static let textField = Style<TextField> {
            $0.textColor = UIColor(hexString: "#310c4d")
            $0.textAlignment = .center
        }
        static let button = Style<Button> {
            $0.setTitleColor(UIColor(hexString: "#310c4d"), for: .normal)
            $0.setTitleColor(UIColor(hexString: "#8c759b"), for: .highlighted)
        }
        static let separator = Style<View> {
            $0.backgroundColor = UIColor(hexString: "#bdb2c4")
        }
    }
}
