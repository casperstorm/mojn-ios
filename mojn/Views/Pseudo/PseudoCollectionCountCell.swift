//
//  PseudoCollectionCountCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 05/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Layoutless
import UIKit
class PseudoCollectionCountCell: CollectionViewCell {
    static var identifier: String = "PseudoCollectionCountCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var countLabel: Label = Label(style: Stylesheet.count)
    lazy var descriptionLabel: Label = Label(style: Stylesheet.description)

    override var subviewsLayout: AnyLayout {
        return containerView
            .addingLayout(
                stack(.vertical, alignment: .center)(
                    countLabel,
                    descriptionLabel
                ).centeringInParent()
            ).fillingParent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PseudoCollectionCountCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#300c4d")
            $0.layer.cornerRadius = 12
        }
        static let count = Style<UILabel> {
            $0.font = UIFont(name: "PatuaOne-Regular", size: 45)
            $0.textAlignment = .center
            $0.textColor = .white
        }
        static let description = Style<UILabel> {
            $0.font = UIFont(name: "OverpassMono-Light", size: 14)
            $0.textAlignment = .center
            $0.textColor = UIColor(hexString: "#f98b74")
        }
    }
}
