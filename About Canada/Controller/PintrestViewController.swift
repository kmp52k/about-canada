//
//  PintrestViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 23/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

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
        coordinator.animate(alongsideTransition: { (_) in
            self.layout?.numberOfColumns = Utils.shared.getColumnsForView()
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
        return 200
    }
    
    func collectionView(collectionView: UICollectionView, heightForDescriptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        return 200
    }
    
    private func setupView() {
        self.layout?.delegate = self
        self.layout?.numberOfColumns = Utils.shared.getColumnsForView()
        collectionView?.contentInset = UIEdgeInsets(top: Constants.articleInsets / 2, left: Constants.articleInsets / 2, bottom: Constants.articleInsets / 2, right: Constants.articleInsets / 2)
        collectionView?.register(CardCell.self, forCellWithReuseIdentifier: Constants.cardCellIdentifier)
    }
}
