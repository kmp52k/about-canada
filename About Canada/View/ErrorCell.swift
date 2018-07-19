//
//  ErrorCell.swift
//  About Canada
//
//  Created by Krunal Purohit on 18/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import SnapKit
import UIKit


// MARK:- ErrorCell

class ErrorCell: UICollectionViewCell {
    
    var aboutError: ErrorViewModel? {
        didSet {
            self.setupCellView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellView() {
        let imageView = (aboutError?.errorImage)!
        let errorLabel: UILabel = (aboutError?.errorMessage)!
        self.addSubview(imageView)
        self.addSubview(errorLabel)
        self.backgroundColor = UIColor.yellow
        errorLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.left.equalTo(self).offset(Constants.errorMargin)
            make.right.equalTo(self).offset(-Constants.errorMargin)
        }
        imageView.snp.makeConstraints { (make) in
            make.height.lessThanOrEqualTo(Constants.errorImageHeight)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(Constants.errorMargin)
            make.right.equalTo(self).offset(-Constants.errorMargin)
            make.top.greaterThanOrEqualTo(Constants.errorMargin)
            make.bottom.equalTo(errorLabel.snp.top).offset(-Constants.errorMargin)
        }
    }
    
}
