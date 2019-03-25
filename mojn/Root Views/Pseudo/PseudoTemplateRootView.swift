//
//  PseudoTemplateRootView.swift
//  mojn
//
//  Created by Casper Rogild Storm on 25/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Layoutless

public class PseudoTemplateRootView: View, RootView {
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var emojiContainer: View = View(style: Stylesheet.emojiContainer)
    lazy var titleLabel: Label = Label(style: Stylesheet.title)
    lazy var nameLabel: Label = Label(style: Stylesheet.name)
    lazy var phoneLabel: Label = Label(style: Stylesheet.phone)
    lazy var emojiLabel: Label = Label(style: Stylesheet.emoji)
    lazy var button: Button = Button(style: Stylesheet.button)
    
    override public var subviewsLayout: AnyLayout {
        let width: Length = Length(floatLiteral: Float(UIScreen.main.bounds.width / 2))
        let height: Length = 220
        return View()
            .addingLayout(
                stack(.vertical, alignment: .center)(
                    containerView
                        .addingLayout(
                            stack(.vertical, alignment: .center)(
                                emojiContainer.sizing(toWidth: 86, height: 86)
                                    .addingLayout(emojiLabel.centeringInParent()),
                                verticalSpacing(10),
                                titleLabel,
                                nameLabel,
                                phoneLabel)
                                .centeringInParent())
                        .sizing(toWidth: width, height: height),
                    verticalSpacing(12),
                    button.sizing(toWidth: width, height: 44))
                    .stickingToParentEdges(left: 0, right: 0, top: 40))
            .fillingParent()
    }
}

extension PseudoTemplateRootView {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
        }
        static let name = Style<UILabel> {
            $0.font = UIFont(name: "OverpassMono-Light", size: 12)
            $0.textAlignment = .center
            $0.textColor = UIColor(hexString: "#8c759b")
        }
        static let phone = Style<UILabel> {
            $0.font = UIFont(name: "OverpassMono-Light", size: 12)
            $0.textAlignment = .center
            $0.textColor = UIColor(hexString: "#8c759b")
        }
        static let title = Style<UILabel> {
            $0.font = UIFont(name: "PatuaOne-Regular", size: 24)
            $0.textAlignment = .center
            $0.textColor = UIColor(hexString: "#370957")
        }
        static let emoji = Style<UILabel> {
            $0.font = .boldSystemFont(ofSize: 40)
            $0.textAlignment = .center
        }
        static let emojiContainer = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#f3ecec")
            $0.layer.cornerRadius = 43
        }
        static let button = Style<Button> {
            $0.setTitle("Create this Pseudo?", for: .normal)
            $0.setTitleColor(UIColor(hexString: "#472761"), for: .normal)
            $0.setTitleColor(UIColor(hexString: "#bdb2c4"), for: .highlighted)
            $0.titleLabel?.font = UIFont(name: "OverpassMono-Light", size: 12)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 22
        }
    }
}
