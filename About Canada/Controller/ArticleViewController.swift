//
//  ArticleViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 20/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- ArticleViewController

// Carousal View Controller for Articles

class ArticleViewController: CollectionViewController {
    
    
    // MARK:- Public
    
    var articleViewModels: [ArticleViewModel] = []
    var currentPage = 0
    let pagingLabel = Constants.pagingLabel
    let backButton = Constants.backButton
    
    
    // MARK:- Internal: Inheritance UIView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.navigateSlide()
    }
    
    // MARK:- Internal: Inheritance UIView
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            // Invalidating active layout to properly set articles accordong to updated orientation
            self.collectionView?.collectionViewLayout.invalidateLayout()
            // Readjusting current slide to be centered in view
            self.navigateSlide()
        }) { (_) in }
    }
    
    
    // MARK:- Internal: Inheritance UICollectionView
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let articleCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.carousalCellIdentifier, for: indexPath) as! CarousalCell
        articleCell.article = articleViewModels[indexPath.row]
        return articleCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return articleViewModels.count
    }
    
    
    // MARK:- Internal: Inheritance UIScrollView
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        self.currentPage = Int(targetContentOffset.pointee.x / self.view.frame.width)
        self.pagingLabel.text = "\(Constants.pagingText)\(self.currentPage + 1) / \(self.articleViewModels.count)"
    }
    
    
    // MARK:- Internal: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    // MARK:- Private
    
    private func setupView() {
        
        self.collectionView?.backgroundColor = Constants.carousalBackgroudColor
        self.collectionView?.isPagingEnabled = true
        
        self.layout?.minimumInteritemSpacing = 0
        self.layout?.minimumLineSpacing = 0
        self.layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.layout?.scrollDirection = .horizontal
        
        self.collectionView?.register(CarousalCell.self, forCellWithReuseIdentifier: Constants.carousalCellIdentifier)
        
        self.collectionView?.addSubview(backButton)
        self.backButton.anchor(self.collectionView?.superview?.topAnchor, left: self.collectionView?.superview?.leftAnchor, bottom: nil, right: nil, topConstant: 28, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        self.backButton.addTapGestureRecognizer { // Handling Tap event on Back button
            self.dismiss(animated: true, completion: nil)
        }
        
        self.collectionView?.superview?.addSubview(self.pagingLabel)
        self.pagingLabel.anchor(self.backButton.bottomAnchor, left: self.backButton.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 14)
    }
    
    private func navigateSlide() {
        
        if self.currentPage > 0 {
            let indexPath = IndexPath(item: self.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        // As currentPage is startin from 0 adding 1 for display
        self.pagingLabel.text = "\(Constants.pagingText)\(self.currentPage + 1) / \(self.articleViewModels.count)"
    }
        
}
