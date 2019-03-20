//
//  NumberDefaultCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 20/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Layoutless

class NumberDefaultCell: TableViewCell {
    static var identifier: String = "NumberDefaultCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var numberLabel: Label = Label(style: Stylesheet.number)
    lazy var pseudoLabel: Label = Label(style: Stylesheet.pseudo)
    
    override var subviewsLayout: AnyLayout {
        return containerView
            .addingLayout(
                stack(.vertical)(
                    numberLabel,
                    pseudoLabel
                ).insetting(leftBy: 16, rightBy: 0, topBy: 0, bottomBy: 0).centeringVerticallyInParent()
            )
            .fillingParent()
    }
}

extension NumberDefaultCell {
    enum Stylesheet {
        static let container = Style<View> {
            $0.backgroundColor = UIColor(hexString: "#f98b74")
        }
        static let number = Style<Label> {
            $0.textAlignment = .left
            $0.textColor = UIColor(hexString: "#310c4d")
            $0.font = UIFont(name: "PatuaOne-Regular", size: 22)
        }
        static let pseudo = Style<Label> {
            $0.textAlignment = .left
            $0.textColor = UIColor(hexString: "#973521")
            $0.font = UIFont(name: "OverpassMono-Light", size: 13)
        }
    }
}
