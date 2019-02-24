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
    let nameLabel = UILabel(style: Stylesheet.name)
    let phoneLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var subviewsLayout: AnyLayout {
        return stack(.vertical)(
            nameLabel.fillingParent(insets: 16),
            phoneLabel
        ).fillingParent()
    }
}

extension PseudoCell {
    enum Stylesheet {
        static let name = Style<UILabel> {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .blue
            $0.backgroundColor = .red
        }
    }
}
