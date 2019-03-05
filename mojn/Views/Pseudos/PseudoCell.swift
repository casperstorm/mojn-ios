//
//  PseudoCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 24/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless

class PseudoCell: CollectionViewCell {
    static var identifier: String = "PseudoCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var emojiContainer: View = View(style: Stylesheet.emojiContainer)
    lazy var titleLabel: Label = Label(style: Stylesheet.title)
    lazy var nameLabel: Label = Label(style: Stylesheet.name)
    lazy var phoneLabel: Label = Label(style: Stylesheet.phone)
    lazy var emojiLabel: Label = Label(style: Stylesheet.emoji)

    override var subviewsLayout: AnyLayout {
        return containerView.addingLayout(
            stack(.vertical, alignment: .center)(
                emojiContainer.sizing(toWidth: 86, height: 86)
                    .addingLayout(emojiLabel.centeringInParent()),
                verticalSpacing(10),
                titleLabel,
                nameLabel,
                phoneLabel
                ).centeringInParent()
            )
        .fillingParent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PseudoCell {
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
    }
}
