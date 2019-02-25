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
    let titleLabel = Label(style: Stylesheet.title)
    let nameLabel = Label(style: Stylesheet.name)
    let phoneLabel = Label(style: Stylesheet.phone)
    let containerView = View(style: Stylesheet.container)
    
    override var subviewsLayout: AnyLayout {
        return containerView.addingLayout(
            stack(.vertical)(
                titleLabel,
                nameLabel,
                phoneLabel
                )
                .centeringHorizontallyInParent()
                .centeringVerticallyInParent()
            )
            .fillingParent(insets: 8)
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
            $0.backgroundColor = UIColor(hexString: "#282828")
            $0.layer.cornerRadius = 8
        }
        static let name = Style<UILabel> {
            $0.font = .systemFont(ofSize: 14)
            $0.textAlignment = .center
            $0.textColor = .white
        }
        static let phone = Style<UILabel> {
            $0.font = .systemFont(ofSize: 14)
            $0.textAlignment = .center
            $0.textColor = .white
        }
        static let title = Style<UILabel> {
            $0.font = .boldSystemFont(ofSize: 28)
            $0.textAlignment = .center
            $0.textColor = .white
        }
    }
}
