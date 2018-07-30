//
//  AboutViewLayout.swift
//  About Canada
//
//  Created by Krunal Purohit on 25/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- AboutLayoutDelegate

protocol AboutLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat
}


// MARK:- AboutViewLayout

class AboutViewLayout: UICollectionViewFlowLayout {
    
    var delegate: AboutLayoutDelegate!
    
    private var cachedWidth: CGFloat = 0.0
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        if let collectionView = collectionView {
            let insets = collectionView.contentInset
            return collectionView.bounds.width - (insets.left + insets.right)
        }
        return 0
    }
    private var numberOfItems = 0
    
    
    // MARK:- Internal: Inheritance UICollectionViewLayout
    
    override func prepare() {
        
        guard let collectionView = self.collectionView else { return }
        
        let numberOfColumns = Utils.shared.getColumnsForView()
        let cellWidth = Utils.shared.getArticleCellSize().width
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        // Reset layout on orientation or number of items change
        if self.contentWidth != self.cachedWidth || self.numberOfItems != numberOfItems {
            self.attributesCache = []
            self.contentHeight = 0
            self.numberOfItems = numberOfItems
        }
        
        if self.attributesCache.isEmpty {
            self.cachedWidth = self.contentWidth
            var xOffset = [CGFloat]()
            
            // Setting initial X offsets for columns
            for column in 0 ..< Int(numberOfColumns) {
                xOffset.append(CGFloat(column) * cellWidth + self.sectionInset.left + self.minimumInteritemSpacing * CGFloat(column))
            }
            
            // Initializing starting column and Y offsets
            var column = 0
            var yOffset = [CGFloat](repeating: self.sectionInset.top, count: Int(numberOfColumns))
            
            // Loop through all items for setting Y offsets
            for row in 0 ..< numberOfItems {
                let indexPath = IndexPath(row: row, section: 0)
                
                // Get cell height from delegate
                let cellHeight = self.delegate.collectionView(collectionView: collectionView, heightForCellAtIndexPath: indexPath, width: cellWidth)
                
                // Crerating frame and attribures for cell and add to cache
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: cellWidth, height: cellHeight)
                let insetFrame = frame.insetBy(dx: 0, dy: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath) // #4
                attributes.frame = insetFrame
                self.attributesCache.append(attributes)
                
                // Increasing content height as rows get filled
                self.contentHeight = max(self.contentHeight, frame.maxY) + self.sectionInset.bottom
                
                // Updating Y offsets for next row.
                yOffset[column] = yOffset[column] + cellHeight + self.minimumLineSpacing
                
                // starting from 0 if all specified columns get filled by an item reset column number to 0 for filling 2nd row and so on.
                if column >= (Int(numberOfColumns) - 1) {
                    column = 0
                } else {
                    column = column + 1
                }
            }
        }
    }
    
    override public var collectionViewContentSize: CGSize {
        
        return CGSize(width: self.contentWidth, height: self.contentHeight)
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in self.attributesCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
