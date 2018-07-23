//
//  PintrestLayout.swift
//  About Canada
//
//  Created by Krunal Purohit on 23/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit

protocol PintrestLayoutDeligate: class {
    func collectionView(collectionView: UICollectionView, heightForImageAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForDescriptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}


// MARK:- PintrestLayout

class PintrestLayout: UICollectionViewLayout {

    var delegate: PintrestLayoutDeligate?
    
    var numberOfColumns: CGFloat = 2
    var cellPadding: CGFloat = Constants.articleInsets / 2
    
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return (collectionView!.bounds.width - (insets.left + insets.right))
    }
    
    private var attributesCache = [PinterestLayoutAttributes]()
    
    override func prepare()
    {
        if attributesCache.isEmpty {
            let columnWidth = contentWidth / numberOfColumns
            var xOffsets = [CGFloat]()
            for column in 0 ..< Int(numberOfColumns) {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var column = 0
            var yOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))
            
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                
                // calculate the frame
                let width = columnWidth - cellPadding * 2
                
                let imageHeight: CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForImageAt: indexPath, with: width))!
                let descriptionHeight: CGFloat = (delegate?.collectionView(collectionView: collectionView!, heightForDescriptionAt: indexPath, with: width))!
                
                let height: CGFloat = cellPadding + imageHeight + descriptionHeight + cellPadding
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                // create layout attributes
                let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
                attributes.imageHeight = imageHeight
                attributes.frame = insetFrame
                attributesCache.append(attributes)
                
                // update column, yOffset
                contentHeight = max(contentHeight, frame.maxY)
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
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in attributesCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
}
// UICollectionViewFlowLayout
// abstract

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes
{
    var imageHeight: CGFloat = 0.0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.imageHeight = imageHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PinterestLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        
        return false
    }
}

