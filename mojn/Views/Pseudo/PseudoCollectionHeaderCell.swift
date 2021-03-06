//
//  PseudoCollectionHeaderCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 08/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import Layoutless
import UIKit

class PseudoCollectionHeaderCell: CollectionViewCell {
    static var identifier: String = "PseudoHeaderCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var imageView: ImageView = ImageView(image: UIImage(imageLiteralResourceName: "icHand"))
    
    override var subviewsLayout: AnyLayout {
        return containerView.addingLayout(
            stack(.vertical, alignment: .center)(
                verticalSpacing(40),
                imageView.sizing(toWidth: 60, height: 94),
                verticalSpacing(40)
            ).centeringInParent()).fillingParent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PseudoCollectionHeaderCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.layer.cornerRadius = 12
        }
    }
}
