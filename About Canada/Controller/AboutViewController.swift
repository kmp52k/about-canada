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
            self.collectionView?.collectionViewLayout.invalidateLayout()
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
        
        let vc = ArticleViewController()
        vc.articleViewModels = articleViewModels
        vc.currentPage = indexPath.row
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // MARK:- Internal: Inheritance CollectionViewController
    
    override func handleRefresh() {
        
        LazyImageView.clearImageCache()
        Service.shared.getAboutData()
    }
    
    
    // MARK:- Internal: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height + collectionView.contentOffset.y
        if self.aboutError != nil { return CGSize(width: collectionView.frame.width, height: height) }
        else {
            return CGSize(width: Utils.shared.getArticleCellSize().width, height: Utils.shared.getArticleCellSize().height)
        }
    }
    
    
    // MARK:- Internal, AboutServiceDeligate
    
    func handleAboutData(aboutResponse: About) {
        
        self.clearData()
        self.about = aboutResponse
        self.navigationItem.title = self.about?.title
        if !(self.about?.rows?.isEmpty)! {
            for article in (self.about?.rows)! {
                guard let _ = article.title else { continue }
                let articleVM = ArticleViewModel(article: article, size: (self.collectionView?.frame.size)!)
                self.articleViewModels.append(articleVM)
            }
        }
        self.collectionView?.reloadData()
    }
    
    func handleAboutError(aboutError: AboutError) {
        
        self.clearData()
        self.aboutError = aboutError
        self.collectionView?.reloadData()
    }
    
    
    // MARK:- Private
    
    private func setupView() {
        
        self.collectionView?.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.anchorCenterSuperview()
        self.activityIndicatorView.startAnimating()
        self.collectionView?.backgroundColor = Constants.articleBackgroundColor
        
        self.navigationItem.title = Constants.navBarTitle
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationTitle = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            label.text = Constants.navBarTitle
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: Constants.navigationTitleFontSize)
            return label
        }()
        self.navigationItem.titleView = self.navigationTitle
        
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
    
    private func clearData() {
        
        if self.activityIndicatorView.isAnimating { self.activityIndicatorView.stopAnimating() }
        if self.refresher.isRefreshing { self.refresher.endRefreshing() }
        self.articleViewModels.removeAll()
    }
    
}
