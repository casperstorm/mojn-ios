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
    var longPress: UILongPressGestureRecognizer?
    var shaking: Bool = false
    
    lazy var containerView: View = View(style: Stylesheet.container)
    lazy var deleteContainer: View = View(style: Stylesheet.deleteContainer)
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
        return View()
            .addingLayout(
                containerView.addingLayout(
                    stack(.vertical, alignment: .center)(
                        emojiContainer.sizing(toWidth: 86, height: 86)
                            .addingLayout(emojiLabel.centeringInParent()),
                        verticalSpacing(10),
                        descriptionLabel,
                        nameLabel,
                        phoneLabel
                        )
                        .centeringInParent())
                    .fillingParent())
            .addingLayout(
                deleteContainer.sizing(toWidth: 35, height: 35).stickingToParentEdges(left: -8, top: -8))
            .fillingParent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress?.minimumPressDuration = 0.75
        contentView.addGestureRecognizer(longPress!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if (gesture.state == .ended) {
            return
        }
    
        if(!shaking) {
            shake()
        }
    }
}

extension PseudoCollectionDefaultCell {
    func shake() {
        let startAngle: Float = (-1) * 3.14159 / 180
        let stopAngle = -startAngle
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.duration = 0.025
        anim.repeatCount = 2
        anim.autoreverses = true
        anim.fromValue = NSNumber(value: startAngle as Float)
        anim.toValue = NSNumber(value: 3 * stopAngle as Float)
        anim.autoreverses = true
        anim.duration = 0.2
        anim.repeatCount = 10000
        anim.timeOffset = 290 * drand48()
        
        layer.add(anim, forKey:"shaking")
        shaking = true
        
        presentDeleteContainer()
    }
    
    func stopShake() {
        layer.removeAnimation(forKey:"shaking")
        shaking = false
        
        hideDeleteContainer()
    }
}

extension PseudoCollectionDefaultCell {
    func presentDeleteContainer() {
        self.deleteContainer.alpha = 0
        self.deleteContainer.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        
        UIView.animate(withDuration: 0.25, delay: 0.10, usingSpringWithDamping: 5, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            self.deleteContainer.transform = CGAffineTransform.identity
            self.deleteContainer.alpha = 1
        })
    }
    
    func hideDeleteContainer() {
        self.deleteContainer.alpha = 1
        self.deleteContainer.transform = CGAffineTransform.identity
        
        
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            self.deleteContainer.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self.deleteContainer.alpha = 0
        }, completion: { _ in
            self.deleteContainer.transform = CGAffineTransform(scaleX: 0, y: 0)
        })
    }
}

extension PseudoCollectionDefaultCell {
    enum Stylesheet {
        static let container = Style<UIView> {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
        }
        static let deleteContainer = Style<View> {
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 35/2
            $0.transform = CGAffineTransform(scaleX: 0, y: 0)

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
