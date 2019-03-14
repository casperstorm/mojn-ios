//
//  PseudoCollectionRootView.swift
//  mojn
//
//  Created by Casper Rogild Storm on 04/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless
import Siesta

public class PseudoCollectionRootView: View, RootView {
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: PseudoCollectionLayout())
        cv.apply(Stylesheet.collectionView)
        return cv
    }()
    
    override public var subviewsLayout: AnyLayout {
        return collectionView.fillingParent()
    }
}

public extension PseudoCollectionRootView {
    enum Stylesheet {
        static let collectionView = Style<UICollectionView> {
            $0.backgroundColor = UIColor(hexString: "#f7e2dd")
            $0.alwaysBounceVertical = true
            $0.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            
            $0.register(PseudoCollectionDefaultCell.self, forCellWithReuseIdentifier: PseudoCollectionDefaultCell.identifier)
            $0.register(PseudoCollectionAddCell.self, forCellWithReuseIdentifier: PseudoCollectionAddCell.identifier)
            $0.register(PseudoCollectionCountCell.self, forCellWithReuseIdentifier: PseudoCollectionCountCell.identifier)
            $0.register(PseudoCollectionHeaderCell.self, forCellWithReuseIdentifier: PseudoCollectionHeaderCell.identifier)
            $0.register(PseudoCollectionEmptyCell.self, forCellWithReuseIdentifier: PseudoCollectionEmptyCell.identifier)
        }
    }
}
