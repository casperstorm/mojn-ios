//
//  PseudoCollectionLayout.swift
//  mojn
//
//  Created by Casper Rogild Storm on 05/03/2019.
//  Copyright © 2019 Casper Rogild Storm. All rights reserved.
//

import Foundation
import UIKit

protocol PseudoCollectionLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForCellAtIndexPath indexPath:IndexPath) -> CGFloat
}

class PseudoCollectionLayout: UICollectionViewLayout {
    weak var delegate: PseudoCollectionLayoutDelegate!
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

        for section in 0 ..< collectionView.numberOfSections {
            for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                
                let indexPath = IndexPath(item: item, section: section)
                let header: Bool = (section == 0 && item == 0)
                
                let x = header ? 0 : xOffset[column]
                let y = header ? 0 : yOffset[column]
                let width = header ? contentWidth : columnWidth
                
                let cellHeight = delegate.collectionView(collectionView, heightForCellAtIndexPath: indexPath)
                let height = cellPadding * 2 + cellHeight
                let frame = CGRect(x: x, y: y, width: width, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                
                if (header) {
                    yOffset[column] = yOffset[column] + height
                    yOffset[column + 1] = yOffset[column + 1] + height
                } else {
                    yOffset[column] = yOffset[column] + height
                    column = column < (numberOfColumns - 1) ? (column + 1) : 0
                }
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }


}
