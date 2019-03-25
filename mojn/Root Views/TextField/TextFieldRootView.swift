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
    lazy var textLabel: Label = Label(style: Stylesheet.label)
    lazy var separatorView: View = View(style: Stylesheet.separator)
    lazy var textField: TextField = {
        let tf = TextField(style: Stylesheet.textField)
        return tf
    }()
    
    override public var subviewsLayout: AnyLayout {
        let sideGutter: Length = 22
        let topGutter: Length  = 100
        return stack(.vertical)(
                textField.sizing(toHeight: 50),
                separatorView.sizing(toHeight: 0.5),
                verticalSpacing(12),
                textLabel
            ).stickingToParentEdges(left: sideGutter, right: sideGutter, top: topGutter)
        
    }
}

extension TextFieldRootView {
    enum Stylesheet {
        static let textField = Style<TextField> {
            $0.backgroundColor = UIColor(hexString: "#f98b74")
            $0.font =  UIFont(name: "OverpassMono-Light", size: 32)
            $0.textColor = UIColor(hexString: "#310c4d")
            $0.textAlignment = .center
            $0.placeholder = "Placeholder"
        }
        static let separator = Style<View> {
            $0.backgroundColor = .white
            $0.alpha = 0.2
        }
        static let label = Style<Label> {
            $0.font =  UIFont(name: "OverpassMono-Light", size: 14)
            $0.textColor = UIColor(hexString: "#973521")
            $0.textAlignment = .center
            $0.numberOfLines = 0
        }
    }
}

