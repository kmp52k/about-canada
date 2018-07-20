//
//  ArticleViewController.swift
//  About Canada
//
//  Created by Krunal Purohit on 20/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit

class ArticleViewController: CollectionViewController {
    
    let backdrop: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        return view
    }()
    
    var articles: [ArticleViewModel]? {
        didSet {
            self.setupView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.collectionView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.collectionView?.backgroundView = self.backdrop
        self.backdrop.addTapGestureRecognizer {
            self.dismiss(animated: true, completion: nil)
        }
        self.collectionView?.addSubview(backdrop)
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.isPagingEnabled = true
        
        self.layout?.scrollDirection = .horizontal
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height-200)
    }

}
