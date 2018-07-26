//
//  AboutViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit
import Alamofire


// MARK:- AboutViewController

// Root View Controller for Application Landing Screen

class AboutViewController: CollectionViewController, AboutServiceDeligate {
    
    
    // MARK:- Public
    
    var refresher: UIRefreshControl!
    var navigationTitle: UILabel?
    var aboutError: AboutError?
    var about: About?
    var articleViewModels: [ArticleViewModel] = []
    var navBarView: UIView?
    
    
    // MARK:- Internal: Inheritance UIView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupView()
        Service.shared.deligate = self
        Service.shared.getAboutData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            // Invalidating active layout to properly set articles accordong to updated orientation
            self.collectionView?.collectionViewLayout.invalidateLayout()
            // Hiding navigation bar in case of iPhone device is in Lanscape mode
            self.navBarView?.isHidden = Utils.shared.getNavBarHidden()
        }) { (_) in }
    }
    
    
    // MARK:- Internal: Inheritance UICollectionView
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.aboutError != nil {
            let errorCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.errorCellIdentifier, for: indexPath) as! ErrorCell
            let errorViewModel = ErrorViewModel(error: aboutError!)
            errorCell.aboutError = errorViewModel
            return errorCell
        } else {
            let articleCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.articleCellIdentifier, for: indexPath) as! ArticleCell
            articleCell.article = articleViewModels[indexPath.row]
            return articleCell
        }
    }
    
    
    // MARK:- Internal: Inheritance UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.aboutError != nil { return 1 }
        else {
            return articleViewModels.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.aboutError == nil {
            let carousalController = ArticleViewController()
            carousalController.articleViewModels = articleViewModels
            carousalController.currentPage = indexPath.row
            carousalController.modalTransitionStyle = .crossDissolve
            carousalController.modalPresentationStyle = .overCurrentContext
            self.present(carousalController, animated: true, completion: nil)
        }
    }
    
    
    // MARK:- Internal: Inheritance CollectionViewController
    
    override func handleRefresh() {
        
        LazyImageView.clearImageCache()
        Service.shared.getAboutData()
    }
    
    
    // MARK:- Internal: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.aboutError != nil {
            // Making Error cell full screen size.
            let height = self.collectionView!.frame.height + collectionView.contentOffset.y - (2 * Constants.articleInsets)
            return CGSize(width: self.collectionView!.frame.width, height: height)
        }
        else {
            return CGSize(width: Utils.shared.getArticleCellSize().width, height: Utils.shared.getArticleCellSize().height)
        }
    }
    
    
    // MARK:- Internal, AboutServiceDeligate
    
    func handleAboutData(aboutResponse: About) {
        
        self.clearData() // To handle fresh data from Pull to Refresh
        self.about = aboutResponse
        self.navigationTitle?.text = self.about?.title
        self.navigationItem.titleView = self.navigationTitle
        if !(self.about?.rows?.isEmpty)! {
            for article in (self.about?.rows)! {
                guard let _ = article.title else { continue } // Ignoring articles without Title
                let articleViewModel = ArticleViewModel(article: article)
                self.articleViewModels.append(articleViewModel)
            }
        }
        self.navigationItem.rightBarButtonItem?.isEnabled = true // Since data is available enabling navigation to CardsView
        self.aboutError = nil
        self.collectionView?.reloadData()
    }
    
    func handleAboutError(aboutError: AboutError) {
        
        self.clearData()
        self.aboutError = aboutError
        self.navigationItem.rightBarButtonItem?.isEnabled = false // Since data is not available disabling navigation to CardsView
        self.collectionView?.reloadData()
    }
    
    
    // MARK:- Private
    
    private func setupView() {
        
        // As per requirement removing indicator view during load
//        self.collectionView?.addSubview(self.activityIndicatorView)
//        self.activityIndicatorView.anchorCenterSuperview()
//        self.activityIndicatorView.startAnimating()
        self.collectionView?.backgroundColor = Constants.articleBackgroundColor
        
        self.setupNavBar()
        
        self.layout?.minimumInteritemSpacing = Constants.articleInsets
        self.layout?.minimumLineSpacing = 0
        self.layout?.sectionInset = UIEdgeInsets(top: Constants.articleInsets, left: Constants.articleInsets, bottom: Constants.articleInsets, right: Constants.articleInsets)
        
        self.collectionView?.register(ArticleCell.self, forCellWithReuseIdentifier: Constants.articleCellIdentifier)
        self.collectionView?.register(ErrorCell.self, forCellWithReuseIdentifier: Constants.errorCellIdentifier)
        
        self.refresher = self.getRefreshControl()
        if #available(iOS 10.0, *) {
            self.collectionView?.refreshControl = self.refresher
        } else {
            // Fallback on earlier versions
            self.collectionView?.addSubview(self.refresher)
        }
    }
    
    private func setupNavBar() {
        
        navigationController?.navigationBar.tintColor = .white
        self.navBarView?.isHidden = Utils.shared.getNavBarHidden()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationTitle = {
            let label = UILabel()
            label.text = Constants.navBarTitle
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: Constants.navigationTitleFontSize)
            return label
        }()
        let cardsButton = UIButton(type: .system)
        cardsButton.contentMode = .scaleAspectFill
        cardsButton.addTarget(self, action: #selector(handleCardsButton), for: .touchUpInside)
        cardsButton.setImage(Constants.cardsImage, for: .normal)
        self.navigationItem.titleView = self.navigationTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cardsButton)
        
        // Disabling Navigation to CardsView untill the data is available
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func clearData() {
        
        if self.activityIndicatorView.isAnimating { self.activityIndicatorView.stopAnimating() }
        if self.refresher.isRefreshing { self.refresher.endRefreshing() }
        self.articleViewModels.removeAll()
    }
    
    @objc private func handleCardsButton() {
        
        let layout = PintrestLayout() // Custom layout for CardsView
        let cardsController = PintrestViewController(collectionViewLayout: layout)
        cardsController.articleViewModels = self.articleViewModels
        self.navigationController?.pushViewController(cardsController, animated: true)
    }
    
}
