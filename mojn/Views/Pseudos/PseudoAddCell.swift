//
//  PseudoAddCell.swift
//  mojn
//
//  Created by Casper Rogild Storm on 05/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless

fileprivate class CrossView: View {
    lazy var verticalView: View = View(style: Stylesheet.line)
    lazy var horizontalView: View = View(style: Stylesheet.line)
    
    override var subviewsLayout: AnyLayout {
        return View()
            .addingLayout(
                verticalView.sizing(toWidth: 40, height: 8).centeringInParent())
            .addingLayout(
                horizontalView.sizing(toWidth: 8, height: 40).centeringInParent())
            .centeringInParent()
    }

    enum Stylesheet {
        static let line = Style<UIView> {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 4
        }
    }
}

class PseudoAddCell: CollectionViewCell {
    static var identifier: String = "PseudoAddCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    fileprivate lazy var crossView: CrossView = CrossView()
    
    override var subviewsLayout: AnyLayout {
        return containerView.addingLayout(crossView.centeringInParent()).fillingParent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PseudoAddCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#f98b74")
            $0.layer.cornerRadius = 12
        }
    }
}
