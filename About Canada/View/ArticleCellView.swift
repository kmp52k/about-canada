//
//  ArticleCellView.swift
//  About Canada
//
//  Created by Krunal Purohit on 17/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- ArticleCell

class ArticleCell: UICollectionViewCell {
    
    
    // MARK:- Internal
    
    var article: ArticleViewModel! {
        didSet {
            self.setupCellView()
        }
    }
    
    let articleName: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = Constants.articleNameLines
        label.textColor = Constants.articleNameColor
        label.font = Constants.articleNameFont
        return label
    }()
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = Constants.articleDescriptionLines
        label.textColor = Constants.articleDescriptionColor
        label.font = Constants.articleDescriptionFont
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
        view.backgroundColor = Constants.articleDeviderLine
        return view
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupCellView() {
        
        self.articleName.text = self.article.title
        self.descriptionText.text = self.article.description
        self.addSubview(self.articleName)
        self.addSubview(self.articleImage)
        self.addSubview(self.descriptionText)
        self.addSubview(self.dividerLineView)

        self.articleImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: Constants.articleImageSize, heightConstant: Constants.articleImageSize)
        
        self.articleName.anchor(articleImage.topAnchor, left: articleImage.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 20)
        
        self.descriptionText.anchor(self.articleName.bottomAnchor, left: self.articleName.leftAnchor, bottom: nil, right: self.articleName.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.dividerLineView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 1, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        if !self.article.imageURL.isEmpty {
            self.articleImage.loadImageUsingURLString(urlString: self.article.imageURL)
        }
    }
}
