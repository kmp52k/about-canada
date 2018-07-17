//
//  AboutViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- AboutViewController

class AboutViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let articleCellIdentifier = "articleCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.yellow
        self.collectionView?.register(ArticleCell.self, forCellWithReuseIdentifier: articleCellIdentifier)
        self.navigationItem.title = Constants.navBarTitle
        print("getAboutData")
        Service.shared.getAboutData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let articleCell = collectionView.dequeueReusableCell(withReuseIdentifier: articleCellIdentifier, for: indexPath) as! ArticleCell
        articleCell.articleName.text = "\(indexPath)"
        return articleCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(200))
    }
}
