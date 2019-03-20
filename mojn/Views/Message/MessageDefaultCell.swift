//
//  MessageDefaultCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 12/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Layoutless

class MessageDefaultCell: TableViewCell {
    static var identifier: String = "ConversationTableDefaultCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var recipientLabel: Label = Label(style: Stylesheet.recipient)
    lazy var snippetLabel: Label = Label(style: Stylesheet.snippet)
    lazy var timeLabel: Label = Label(style: Stylesheet.time)
    lazy var separatorView: View = View(style: Stylesheet.separator)
    
    override var subviewsLayout: AnyLayout {
        let gutter: Length = 18
        return containerView.addingLayout(
            stack(.vertical, alignment: .leading)(
                recipientLabel.sizing(toHeight: 24),
                verticalSpacing(6),
                snippetLabel,
                View()).stickingToParentEdges(left: gutter, right: gutter, top: gutter, bottom: gutter)
            ).addingLayout(
                timeLabel.stickingToParentEdges(right: gutter, top: 26)
            ).addingLayout(
                separatorView.sizing(toHeight: 0.5).stickingToParentEdges(left: gutter, right: gutter, bottom: 6)
            ).fillingParent()
    }
}

extension MessageDefaultCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#310c4d")
        }
        static let recipient = Style<UILabel> {
            $0.textAlignment = .left
            $0.textColor = .white
            $0.font = UIFont(name: "PatuaOne-Regular", size: 22)
        }
        static let time = Style<UILabel> {
            $0.textAlignment = .right
            $0.textColor = .white
            $0.font = UIFont(name: "OverpassMono-Light", size: 14)
        }
        static let snippet = Style<Label> {
            $0.textAlignment = .left
            $0.numberOfLines = 3
            $0.textColor = UIColor(hexString: "#f98b74")
            $0.font = UIFont(name: "OverpassMono-Light", size: 14)
        }
        
        static let separator = Style<UIView> {
            $0.backgroundColor = .white
            $0.alpha = 0.2
        }
    }
}
