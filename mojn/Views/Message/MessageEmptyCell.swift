//
//  MessageEmptyCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 20/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Layoutless

class MessageEmptyCell: TableViewCell {
    static var identifier: String = "MessageEmptyCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var recipientPlaceholder: View = View(style: Stylesheet.recipientPlaceholder)
    lazy var snippetPlaceholder1: View = View(style: Stylesheet.snippetPlaceholder)
    lazy var snippetPlaceholder2: View = View(style: Stylesheet.snippetPlaceholder)
    lazy var snippetPlaceholder3: View = View(style: Stylesheet.snippetPlaceholder)
    lazy var timePlaceholder: View = View(style: Stylesheet.timePlaceholder)
    lazy var separatorView: View = View(style: Stylesheet.separator)
    
    override var subviewsLayout: AnyLayout {
        let gutter: Length = 18
        return containerView.addingLayout(
            stack(.vertical, alignment: .leading)(
                recipientPlaceholder.sizing(toWidth: 120, height: 24),
                verticalSpacing(9),
                snippetPlaceholder1.stickingToParentEdges(left: 0, right: 0).sizing(toHeight: 16),
                verticalSpacing(4),
                snippetPlaceholder2.stickingToParentEdges(left: 0, right: 0).sizing(toHeight: 16),
                verticalSpacing(4),
                snippetPlaceholder3.stickingToParentEdges(left: 0, right: 0).sizing(toHeight: 16),
                View()).stickingToParentEdges(left: gutter, right: gutter, top: gutter, bottom: gutter)
            ).addingLayout(
                timePlaceholder.stickingToParentEdges(right: gutter, top: 26).sizing(toWidth: 75, height: 16)
            ).addingLayout(
                separatorView.sizing(toHeight: 0.5).stickingToParentEdges(left: gutter, right: gutter, bottom: 6)
            ).fillingParent()
    }
}

extension MessageEmptyCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#310c4d")
        }
        static let recipientPlaceholder = Style<UIView> {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
            $0.alpha = 0.1
        }
        static let snippetPlaceholder = Style<UIView> {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
            $0.alpha = 0.1
        }
        static let timePlaceholder = Style<UIView> {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
            $0.alpha = 0.1
        }
        static let separator = Style<UIView> {
            $0.backgroundColor = .white
            $0.alpha = 0.2
        }
    }
}
