//
//  PseudoCountCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 05/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Layoutless
import UIKit
class PseudoCountCell: CollectionViewCell {
    static var identifier: String = "PseudoCountCell"
    lazy var containerView: View = View(style: Stylesheet.container)

    override var subviewsLayout: AnyLayout {
        return containerView.fillingParent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PseudoCountCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#300c4d")
            $0.layer.cornerRadius = 12
        }
    }
}
