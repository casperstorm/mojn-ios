//
//  TextFieldRootView.swift
//  mojn
//
//  Created by Casper Rogild Storm on 22/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless

class TextFieldRootView: View, RootView {
    lazy var separatorView: View = View(style: Stylesheet.separator)
    lazy var textField: TextField = {
        let tf = TextField(style: Stylesheet.textField)
        return tf
    }()
    
    override public var subviewsLayout: AnyLayout {
        let heightGutter = 
        return stack(.vertical)(
                textField.sizing(toHeight: 50),
                separatorView.sizing(toHeight: 0.5)
            ).stickingToParentEdges(left: 22, right: 22, top: 150)
        
    }
}

extension TextFieldRootView {
    enum Stylesheet {
        static let textField = Style<TextField> {
            $0.backgroundColor = UIColor(hexString: "#f98b74")
            $0.font =  UIFont(name: "PatuaOne-Regular", size: 32)
            $0.textColor = .white
            $0.textAlignment = .center
            $0.placeholder = "title"
        }
        static let separator = Style<View> {
            $0.backgroundColor = .white
            $0.alpha = 0.2
        }
    }
}

