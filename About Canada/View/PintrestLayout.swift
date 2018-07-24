//
//  PintrestLayout.swift
//  About Canada
//
//  Created by Krunal Purohit on 23/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- Protocol: PintrestLayoutDeligate

protocol PintrestLayoutDeligate: class {
    func collectionView(collectionView: UICollectionView, heightForImageAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForDescriptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}


// MARK:- PintrestLayout

class PintrestLayout: UICollectionViewLayout {

    var delegate: PintrestLayoutDeligate?
    var attributesCache = [PinterestLayoutAttributes]()
    
    private var cellPadding: CGFloat = Constants.articleInsets / 2
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat = 0.0
    
    
    // MARK:- Internal: Inheritance UICollectionViewLayout
    
    override func prepare() {
        
        if attributesCache.isEmpty {
            var xOffsets = [CGFloat]()
            let insets = self.collectionView!.contentInset
            self.contentWidth = (self.collectionView!.bounds.width - (insets.left + insets.right))
            self.contentHeight = 0.0
            let numberOfColumns: CGFloat = Utils.shared.getColumnsForView()
            let columnWidth = self.contentWidth / numberOfColumns
            
            for column in 0 ..< Int(numberOfColumns) {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var column = 0
            var yOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))
            
            for item in 0 ..< self.collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(item: item, section: 0)
                let width = columnWidth - self.cellPadding * 2
                let imageHeight: CGFloat = (self.delegate?.collectionView(collectionView: collectionView!, heightForImageAt: indexPath, with: width))!
                let descriptionHeight: CGFloat = (self.delegate?.collectionView(collectionView: collectionView!, heightForDescriptionAt: indexPath, with: width))!
                let height: CGFloat = self.cellPadding + imageHeight + descriptionHeight + self.cellPadding
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: self.cellPadding, dy: self.cellPadding)
                let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
                attributes.imageHeight = imageHeight
                attributes.frame = insetFrame
                
                self.attributesCache.append(attributes)
                self.contentHeight = max(self.contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                if column >= (Int(numberOfColumns) - 1) {
                    column = 0
                } else {
                    column += 1
                }
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        
        return CGSize(width: self.contentWidth, height: self.contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in self.attributesCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}


// MARK:- PinterestLayoutAttributes

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var imageHeight: CGFloat = 0.0
    
    
    // MARK:- Internal: Inheritance NSCopying
    
    override func copy(with zone: NSZone? = nil) -> Any {
        
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.imageHeight = self.imageHeight
        return copy
    }
    
    
    // MARK:- Internal: Inheritance NSObject
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if let attributes = object as? PinterestLayoutAttributes {
            if attributes.imageHeight == self.imageHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}

