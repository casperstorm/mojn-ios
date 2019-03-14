//
//  PseudoCollectionEmptyCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 13/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless

class PseudoCollectionEmptyCell: CollectionViewCell {
    static var identifier: String = "PseudoCollectionEmptyCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var emojiContainer: View = View(style: Stylesheet.emojiContainer)
    lazy var topPlaceholderView: View = View(style: Stylesheet.topPlaceholder)
    lazy var middlePlaceholderView: View = View(style: Stylesheet.middlePlaceholder)
    lazy var bottomPlaceholderView: View = View(style: Stylesheet.bottomPlaceholder)
    
    override var subviewsLayout: AnyLayout {
        return containerView.addingLayout(
            stack(.vertical, alignment: .center)(
                emojiContainer.sizing(toWidth: 86, height: 86),
                verticalSpacing(10),
                topPlaceholderView.sizing(toWidth: 60, height: 12),
                verticalSpacing(10),
                middlePlaceholderView.sizing(toWidth: 120, height: 6),
                verticalSpacing(10),
                bottomPlaceholderView.sizing(toWidth: 90, height: 6)
                ).centeringInParent()
            )
            .fillingParent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addDashedBorder(color: UIColor(hexString: "#bea6a3"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PseudoCollectionEmptyCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 12
        }
        static let topPlaceholder = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#bea6a3")
            $0.layer.cornerRadius = 6
        }
        static let middlePlaceholder = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#bea6a3")
            $0.layer.cornerRadius = 3
        }
        static let bottomPlaceholder = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#bea6a3")
            $0.layer.cornerRadius = 3
        }
        static let emoji = Style<UILabel> {
            $0.font = .boldSystemFont(ofSize: 40)
            $0.textAlignment = .center
        }
        static let emojiContainer = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#bea6a3")
            $0.layer.cornerRadius = 43
        }
    }
}
