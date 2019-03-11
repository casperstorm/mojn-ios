//
//  ListHeaderView.swift
//  mojn
//
//  Created by Casper Rogild Storm on 11/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless

class ListHeaderView: View {
    fileprivate lazy var containerView: View = View(style: Stylesheet.container)
    fileprivate lazy var emojiContainerView: View = View(style: Stylesheet.emojiContainer)
    fileprivate lazy var titleLabel: Label = Label(style: Stylesheet.title)
    fileprivate lazy var emojiLabel: Label = Label(style: Stylesheet.emoji)

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var emoji: String? {
        didSet {
            emojiLabel.text = emoji
        }
    }
    
    override var subviewsLayout: AnyLayout {
        let gutter: Length = 18
        let height: Length = 150
        return containerView.addingLayout(
            stack(.horizontal)(
                View().addingLayout(
                    titleLabel.stickingToParentEdges(left: gutter).centeringVerticallyInParent()
                ),
                View().addingLayout(
                    emojiContainerView.addingLayout(
                        emojiLabel.centeringInParent()).sizing(toWidth: 66, height: 66).stickingToParentEdges(right: gutter).centeringVerticallyInParent()
            )).sizingToParent().sizing(toHeight: height)
        ).fillingParent()
    }
}

extension ListHeaderView {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#310c4d")
        }
        static let emojiContainer = Style<UIView> {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 33
        }
        static let title = Style<UILabel> {
            $0.font = UIFont(name: "PatuaOne-Regular", size: 32)
            $0.textColor = .white
        }
        static let emoji = Style<UILabel> {
            $0.font = .boldSystemFont(ofSize: 32)
            $0.textAlignment = .center
        }
    }
}
