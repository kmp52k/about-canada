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
            articleName.text = article.title
        }
    }
    
    let articleName: UILabel = {
        let label = UILabel()
        label.text = "Article Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupCellView() {
        addSubview(articleName)
        articleName.snp.makeConstraints { (make) in
            make.height.width.equalTo(self)
        }
    }
}
