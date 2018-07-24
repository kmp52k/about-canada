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

class PintrestViewController: UICollectionViewController, PintrestLayoutDeligate {
    
    var articleViewModels: [ArticleViewModel] = []
    var layout: PintrestLayout?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.layout = collectionView?.collectionViewLayout as? PintrestLayout
        self.setupView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView?.reloadData()
        coordinator.animate(alongsideTransition: { (_) in
            self.layout?.attributesCache.removeAll()
            self.collectionView?.collectionViewLayout.invalidateLayout()
            self.collectionView?.reloadData()
        }) { (_) in }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleViewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cardCellIdentifier, for: indexPath) as! CardCell
        cell.article = articleViewModels[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, heightForImageAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let call = CardCell()
        call.article = self.articleViewModels[indexPath.row]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: (call.articleImage.image?.size)!, insideRect: boundingRect)
        return rect.size.height
    }
    
    func collectionView(collectionView: UICollectionView, heightForDescriptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let titleTextHeight: CGFloat = 36
        let article = self.articleViewModels[indexPath.row]
        let descriptionHeight = article.getDescriptionHeight(withWidth: width - 18)
        print(descriptionHeight)
        return titleTextHeight + 8 + descriptionHeight + 8
    }
    
    private func setupView() {
        self.layout?.delegate = self
        self.collectionView?.contentInset = UIEdgeInsets(top: Constants.articleInsets / 2, left: Constants.articleInsets / 2, bottom: Constants.articleInsets / 2, right: Constants.articleInsets / 2)
        self.collectionView?.register(CardCell.self, forCellWithReuseIdentifier: Constants.cardCellIdentifier)
        self.collectionView?.backgroundColor = Constants.articleBackgroundColor
    }
}
