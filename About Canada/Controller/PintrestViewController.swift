//
//  PintrestViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 23/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import AVKit
import UIKit


// MARK:- PintrestViewController

// Pintrest Cards View controller

class PintrestViewController: UICollectionViewController, PintrestLayoutDeligate {
    
    
    // MARK:- Public
    
    var articleViewModels: [ArticleViewModel] = []
    var layout: PintrestLayout?
    
    
    // MARK:- Internal: Inheritance UIView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.layout = collectionView?.collectionViewLayout as? PintrestLayout
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        // Reloading data to rerender images which were loaded incorrecly during with initial dimensions
        self.collectionView?.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            // Unlike UICollectionViewFlowLayout the UICollectionViewLayout does not respond to orientation change by triggering reload will clear attributes cache.
            self.collectionView?.reloadData()
        }) { (_) in }
        // Reseting layour for proper image rendering
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
    // MARK:- Internal: Inheritance UICollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return articleViewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cardCellIdentifier, for: indexPath) as! CardCell
        cell.article = articleViewModels[indexPath.row]
        return cell
    }
    
    
    // MARK:- Internal: PintrestLayoutDeligate
    
    func collectionView(collectionView: UICollectionView, heightForImageAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        
        // Calculating probable Height of Image for given card width to keep aspect ratio of Image intact
        let call = CardCell()
        call.article = self.articleViewModels[indexPath.row]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: (call.articleImage.image?.size)!, insideRect: boundingRect)
        return rect.size.height
    }
    
    func collectionView(collectionView: UICollectionView, heightForDescriptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        
        // Calculating probable Height taken by Article Title & Description in card for given card width
        let titleTextHeight: CGFloat = 8 + 20 + 8 // 20 as title Height and 8 Padding at Top & Bottom
        let article = self.articleViewModels[indexPath.row]
        let descriptionHeight = article.getDescriptionHeight(withWidth: width - 18) // 8 Padding on Left & Right + 2 to be safe
        return titleTextHeight + 8 + descriptionHeight + 8 // 8 as Top & Bottom Margin
    }
    
    
    // MARK:- Private
    
    private func setupView() {
        
        self.layout?.delegate = self
        self.collectionView?.contentInset = UIEdgeInsets(top: Constants.articleInsets / 2, left: Constants.articleInsets / 2, bottom: Constants.articleInsets / 2, right: Constants.articleInsets / 2)
        self.collectionView?.register(CardCell.self, forCellWithReuseIdentifier: Constants.cardCellIdentifier)
        self.collectionView?.backgroundColor = Constants.articleBackgroundColor
    }
}
