//
//  ErrorViewModel.swift
//  About Canada
//
//  Created by Krunal Purohit on 18/07/18.
//  Copyright © 2018 PwC. All rights reserved.
//

import UIKit


// MARK:- ErrorViewModel

struct ErrorViewModel {
    
    let errorImage: UIImageView = {
        let imageView = UIImageView(image: Constants.errorImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
    
    let errorMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    // Dependancy Injection (DI)
    init(error: AboutError) {
        switch error {
        case AboutError.noNetwork:
            self.errorMessage.text = Constants.noConnectivityMessage
        default:
            self.errorMessage.text = Constants.errorMessage
        }
    }
}
