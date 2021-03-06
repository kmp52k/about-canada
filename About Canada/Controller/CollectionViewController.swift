//
//  CollectionViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 20/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- CollectionViewController

// Parent Controller for About and Article Carousal Views

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    // MARK:- Public
    
    public init() {
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getRefreshControl() -> UIRefreshControl {
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return rc
    }
    
    @objc public func handleRefresh() { }
    
    public var layout: UICollectionViewFlowLayout? {
        
        get { return collectionViewLayout as? UICollectionViewFlowLayout }
    }
}
