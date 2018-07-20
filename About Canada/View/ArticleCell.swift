//
//  ArticleCell.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import SnapKit
import UIKit


// MARK:- ArticleCell

class ArticleCell: UICollectionViewCell {
    
    var article: ArticleViewModel! {
        didSet {
            self.setupCellView()
        }
    }
    
    let articleName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor(red: 152/255, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor(red: 65/255, green: 65/255, blue: 64/255, alpha: 1)
        label.font = UIFont.italicSystemFont(ofSize: 14)
//        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    let articleImage: LazyImageView = {
        let view = LazyImageView(image: Constants.noImage)
        view.contentMode = UIViewContentMode.scaleAspectFill
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 152/255, green: 0, blue: 0, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellow
//
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
//
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        self.layer.shadowRadius = 4
//        self.layer.shadowOpacity = 0.8
//        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupCellView() {
        self.articleName.text = self.article.title
        self.descriptionText.text = self.article.description
        self.addSubview(self.articleName)
        self.addSubview(self.articleImage)
        self.addSubview(self.descriptionText)
        self.addSubview(self.dividerLineView)

        self.articleImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        self.articleName.anchor(articleImage.topAnchor, left: articleImage.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 20)
        
        self.descriptionText.anchor(self.articleName.bottomAnchor, left: self.articleName.leftAnchor, bottom: nil, right: self.articleName.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.dividerLineView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 1, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        if !article.imageURL.isEmpty {
            articleImage.loadImageUsingURLString(urlString: article.imageURL)
        }
    }
}
