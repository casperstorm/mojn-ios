//
//  PseudoCollectionAddCell.swift
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
                verticalView.sizing(toWidth: 40, height: 6).centeringInParent())
            .addingLayout(
                horizontalView.sizing(toWidth: 6, height: 40).centeringInParent())
            .centeringInParent()
    }

    enum Stylesheet {
        static let line = Style<UIView> {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 3
        }
    }
}

class PseudoCollectionAddCell: CollectionViewCell {
    static var identifier: String = "PseudoCollectionAddCell"
    lazy var containerView: View = View(style: Stylesheet.container)
    fileprivate lazy var crossView: CrossView = CrossView()
    
    override var isHighlighted: Bool {
        didSet {
            let fromValue: CGFloat = 1.0
            let toValue: CGFloat = 0.95
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.containerView.transform = CGAffineTransform(scaleX: self.isHighlighted ? toValue : fromValue, y: self.isHighlighted ? toValue : fromValue)
            })
        }
    }
    
    /*
        ConversationTableViewController
        ConversationDetailTableViewController
     */
    
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

extension PseudoCollectionAddCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = UIColor(hexString: "#f98b74")
            $0.layer.cornerRadius = 12
        }
    }
}
