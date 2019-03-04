//
//  PseudosRootView.swift
//  mojn
//
//  Created by Casper Rogild Storm on 04/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit
import Layoutless
import Siesta

public class PseudosRootView: View, RootView {
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(PseudoCell.self, forCellWithReuseIdentifier: PseudoCell.identifier)
        cv.apply(Stylesheet.collectionView)
        return cv
    }()
    
    override public var subviewsLayout: AnyLayout {
        return View()
            .addingLayout(
                collectionView.fillingParent()
            ).fillingParent()
    }
}

public extension PseudosRootView {
    enum Stylesheet {
        static let collectionView = Style<UICollectionView> {
            $0.backgroundColor = UIColor(hexString: "#f3ebea")
            $0.alwaysBounceVertical = true
        }
    }
}
//
//extension PseudosViewModel: ResourceObserver {
//    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
////        guard let pseudos: [Pseudo] = resource.typedContent() else { return }
//
////        self.data = pseudos
////        self.collectionView.reloadData()
////        self.collectionView.refreshControl?.endRefreshing()
//    }
//}
