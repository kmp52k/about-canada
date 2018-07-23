//
//  CollectionViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 20/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- CollectionViewController

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    // MARK:- Public
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.hidesWhenStopped = true
        aiv.color = .black
        return aiv
    }()
    
    public init() {
        
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    open func getRefreshControl() -> UIRefreshControl {
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return rc
    }
    
    @objc open func handleRefresh() { }
    
    open var layout: UICollectionViewFlowLayout? {
        
        get { return collectionViewLayout as? UICollectionViewFlowLayout }
    }
}
