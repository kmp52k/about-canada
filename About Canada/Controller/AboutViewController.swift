//
//  AboutViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- AboutViewController

// Root View Controller for Application Landing Screen

class AboutViewController: UICollectionViewController {
    
    
    // MARK:- Public
    
    var refresher: UIRefreshControl!
    var navigationTitle: UILabel?
    var aboutError: AboutError?
    var about: AboutViewModel?
    var navBarView: UIView?
    var layout: AboutViewLayout?
    
    
    // MARK:- Internal: Inheritance UIView
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupView()
        
        Service.shared.delegate = self
        Service.shared.getAboutData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
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
            articleCell.article = self.about?.rows[indexPath.row]
            return articleCell
        }
    }
    
    
    // MARK:- Internal: Inheritance UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.aboutError != nil { return 1 }
        else {
            return self.about?.rows.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.aboutError == nil {
            // Loading carousal view
            let carousalController = ArticleViewController()
            carousalController.articleViewModels = about?.rows ?? []
            carousalController.currentPage = indexPath.row
            carousalController.modalTransitionStyle = .crossDissolve
            carousalController.modalPresentationStyle = .overCurrentContext
            self.present(carousalController, animated: true, completion: nil)
        }
    }
    
    
    // MARK:- Private
    
    private func setupView() {
        
        self.collectionView?.backgroundColor = Constants.aboutBackgroundColor
        
        self.layout = collectionView?.collectionViewLayout as? AboutViewLayout
        self.layout?.delegate = self
        self.layout?.minimumInteritemSpacing = Constants.articleInsets
        self.layout?.minimumLineSpacing = Constants.articleInsets
        self.layout?.sectionInset = UIEdgeInsets(top: Constants.articleInsets, left: Constants.articleInsets, bottom: Constants.articleInsets, right: Constants.articleInsets)
        
        self.setupNavBar()
        
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
        
        if self.refresher.isRefreshing { self.refresher.endRefreshing() }
        self.about = nil
    }
    
    private func getRefreshControl() -> UIRefreshControl {
        
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return rc
    }
    
    @objc private func handleRefresh() {
        
        Service.shared.getAboutData()
    }
    
    @objc private func handleCardsButton() {
        
        let layout = PintrestLayout() // Custom layout for CardsView
        let cardsController = PintrestViewController(collectionViewLayout: layout)
        cardsController.articleViewModels = self.about?.rows ?? []
        self.navigationController?.pushViewController(cardsController, animated: true)
    }
}


// MARK:- AboutLayoutDelegate

extension AboutViewController: AboutLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat {
        
        if self.aboutError != nil {
            // Making Error cell full screen size.
            return self.collectionView!.frame.width
        }
        else {
            // Left & right padding + image width + 2 as safety margin (8 + 100 + 12 + 8 + 2)
            let approxWidth = width - 130
            // Top & bottom padding + title height + 2 as safety margin (8 + 20 + 16 + 2)
            let cardHeight = (self.about?.rows[indexPath.row].getDescriptionHeight(withWidth: approxWidth))! + 46
            // If article description is too small then take Image height
            return max(cardHeight, 120)
        }
    }
}


// MARK:- AboutServiceDeligate

extension AboutViewController: AboutServiceDelegate {
    
    func handleAboutData(aboutResponse: AboutViewModel) {
        
        self.clearData() // To handle fresh data from Pull to Refresh
        self.about = aboutResponse
        self.navigationTitle?.text = self.about?.title
        self.navigationItem.titleView = self.navigationTitle
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
}
