//
//  PintrestLayout.swift
//  About Canada
//
//  Created by Krunal Purohit on 23/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

//*** Reusable: PintrestLayout ***
// Customized Layout from UICollectionViewLayout for creating view similar to Pintrest supporting both Portrait & Landscape modes.
// PintrestLayout in current implementation can only handle one section in Collection View.
// All the items will be added horizontaly one by one in specified number of columns.
// To support Multiple Sections one more iteration covering all sections needs to be performed in calculation of Y offsets.
// Custom Layout is having feature to store Image Height in Cached Attribute to resuse but due to Lazy loading of Image its not being used.

/*** Example: Cached Image Usage ****
 Override "apply" method in Collection View Controller.
 
 override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
 
 super.apply(layoutAttributes)
 if let attributes = layoutAttributes as? PinterestLayoutAttributes {
 <ImageViewHeightLayoutConstraint>.constant = attributes.imageHeight
 }
 }
 ***/

import UIKit


// MARK:- Protocol: PintrestLayoutDelegate

protocol PintrestLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForImageAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForDescriptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}


// MARK:- PintrestLayout

class PintrestLayout: UICollectionViewLayout {

    var delegate: PintrestLayoutDelegate?
    
    private var attributesCache = [PinterestLayoutAttributes]() // Caching Attributes to prevent recurrent calculations in same orientation
    private var cellPadding: CGFloat = Constants.articleInsets / 2
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        if let collectionView = collectionView {
            let insets = collectionView.contentInset
            return collectionView.bounds.width - (insets.left + insets.right)
        }
        return 0
    }
    private var cachedWidth: CGFloat = 0.0
    private var numberOfItems = 0
    
    
    // MARK:- Internal: Inheritance UICollectionViewLayout
    
    override func prepare() {
        
        guard let collectionView = collectionView else { return }
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        // Reset layout on orientation or number of items change
        if self.contentWidth != self.cachedWidth || self.numberOfItems != numberOfItems {
            self.attributesCache = []
            self.contentHeight = 0
            self.numberOfItems = numberOfItems
        }

        
        if self.attributesCache.isEmpty {
            self.cachedWidth = self.contentWidth
            var xOffsets = [CGFloat]()
            let numberOfColumns: CGFloat = Utils.shared.getColumnsForView() // Depends on Portrait/Landscape mode.
            let columnWidth = self.contentWidth / numberOfColumns
            
            // X offsets will remain same for each Card in same Column
            for column in 0 ..< Int(numberOfColumns) {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            // Initial values foy Y offsets calculation
            var column = 0
            var yOffsets = [CGFloat](repeating: 0, count: Int(numberOfColumns))
            
            // Since there is only one section in collection view, iterating over all item in 0th section
            for item in 0 ..< self.collectionView!.numberOfItems(inSection: 0) {
                
                // Retriving imageHeight & descriptionHeight values from delegate
                let indexPath = IndexPath(item: item, section: 0)
                let width = columnWidth - self.cellPadding * 2
                let imageHeight: CGFloat = (self.delegate?.collectionView(collectionView: collectionView, heightForImageAt: indexPath, with: width))!
                let descriptionHeight: CGFloat = (self.delegate?.collectionView(collectionView: collectionView, heightForDescriptionAt: indexPath, with: width))!
                
                // Createing cell attributes
                let height: CGFloat = self.cellPadding + imageHeight + descriptionHeight + self.cellPadding
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: self.cellPadding, dy: self.cellPadding)
                let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
                attributes.imageHeight = imageHeight
                attributes.frame = insetFrame
                
                // Saving cached attributes for reuse
                self.attributesCache.append(attributes)
                
                // Updating contentHeight & yOffsets so that next item will be having Y offset below previously added item
                self.contentHeight = max(self.contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                
                // starting from 0 if all specified columns get filled by an item reset column number to 0 for filling 2nd row and so on.
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

