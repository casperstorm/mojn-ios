//
//  PseudoCollectionDefaultCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 24/02/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless

class PseudoCollectionDefaultCell: CollectionViewCell {
    static var identifier: String = "PseudoCollectionDefaultCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var emojiContainer: View = View(style: Stylesheet.emojiContainer)
    lazy var descriptionLabel: Label = Label(style: Stylesheet.description)
    lazy var nameLabel: Label = Label(style: Stylesheet.name)
    lazy var phoneLabel: Label = Label(style: Stylesheet.phone)
    lazy var emojiLabel: Label = Label(style: Stylesheet.emoji)
    
    override var isHighlighted: Bool {
        didSet {
            let fromValue: CGFloat = 1.0
            let toValue: CGFloat = 0.95
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.containerView.transform = CGAffineTransform(scaleX: self.isHighlighted ? toValue : fromValue, y: self.isHighlighted ? toValue : fromValue)
            })
        }
    }

    override var subviewsLayout: AnyLayout {
        return containerView.addingLayout(
            stack(.vertical, alignment: .center)(
                emojiContainer.sizing(toWidth: 86, height: 86)
                    .addingLayout(emojiLabel.centeringInParent()),
                verticalSpacing(10),
                descriptionLabel,
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

extension PseudoCollectionDefaultCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
        }
        static let highlightedContainer = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#F6F6F6")
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
        static let description = Style<UILabel> {
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
