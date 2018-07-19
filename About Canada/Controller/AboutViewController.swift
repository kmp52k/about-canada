//
//  AboutViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import Alamofire
import UIKit


// MARK:- AboutViewController

class AboutViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let articleCellIdentifier: String = Constants.articleCellIdentifier
    let errorCellIdentifier: String = Constants.errorCellIdentifier
    var navigationTitle: UILabel?
    var aboutError: AboutError?
    var about: About?
    var articleViewModels: [ArticleViewModel] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupView()
        self.getAboutData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.aboutError != nil {
            let errorCell = collectionView.dequeueReusableCell(withReuseIdentifier: errorCellIdentifier, for: indexPath) as! ErrorCell
            let errorViewModel = ErrorViewModel(error: aboutError!)
            errorCell.aboutError = errorViewModel
            return errorCell
        } else {
            let articleCell = collectionView.dequeueReusableCell(withReuseIdentifier: articleCellIdentifier, for: indexPath) as! ArticleCell
            articleCell.backgroundColor = UIColor.yellow
            articleCell.article = articleViewModels[indexPath.row]
            return articleCell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.aboutError != nil { return 1 }
        else {
            return articleViewModels.count
//            guard let count = about?.rows?.count else { return 0 }
//            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = collectionView.frame.height + collectionView.contentOffset.y
        if self.aboutError != nil { return CGSize(width: collectionView.frame.width, height: height) }
        else { return CGSize(width: collectionView.frame.width - 20, height: Constants.articleHeight) }
    }
    
    
    
    private func setupView() {
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(ArticleCell.self, forCellWithReuseIdentifier: articleCellIdentifier)
        self.collectionView?.register(ErrorCell.self, forCellWithReuseIdentifier: errorCellIdentifier)
        self.navigationItem.title = Constants.navBarTitle
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationTitle = {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            label.text = Constants.navBarTitle
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            return label
        }()
        self.navigationItem.titleView = self.navigationTitle
    }
    
    private func getAboutData() {
        do {
            let network = try Utils.shared.isNetworkAvailable()
            if network {
                Alamofire.request(Constants.serviceURLString).responseString(completionHandler: { (response) in
                    if let dataString = response.value {
                        self.updateViewWithData(data: dataString)
                    } else {
                        print(response.error?.localizedDescription ?? AboutError.serverCallFailure)
                        self.updateViewWithError(aboutError: AboutError.serverCallFailure)
                    }
                })
            }
        } catch AboutError.noNetwork {
            self.updateViewWithError(aboutError: AboutError.noNetwork)
        } catch AboutError.invalidJSON {
            print(Constants.invalidJSONError)
            self.updateViewWithError(aboutError: AboutError.invalidJSON)
        } catch {
            print(#imageLiteral(resourceName: "error").description)
            self.updateViewWithError(aboutError: AboutError.serverCallFailure)
        }
    }
    
    private func updateViewWithError(aboutError: AboutError) {
        self.aboutError = aboutError
        self.collectionView?.reloadData()
    }
    
    private func updateViewWithData(data: String) {
        do {
            self.about = try Utils.shared.parseData(data: data)
            self.navigationItem.title = self.about?.title
            if !(self.about?.rows?.isEmpty)! {
                for article in (self.about?.rows)! {
                    guard let _ = article.title else { continue }
                    let articleVM = ArticleViewModel(article: article)
                    self.articleViewModels.append(articleVM)
                }
            }
            self.collectionView?.reloadData()
        } catch {
            print(Constants.invalidJSONError)
            self.updateViewWithError(aboutError: AboutError.invalidJSON)
        }
    }
    
    
}
