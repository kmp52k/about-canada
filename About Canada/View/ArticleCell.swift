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
            articleName.text = article.articleName.text
            setupCellView()
        }
    }
    
    let articleName: UILabel = {
        let label = UILabel()
        label.text = "Article Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let articleImage: CustomImageView = {
        let view = CustomImageView(image: Constants.noImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIViewContentMode.scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        print()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupCellView() {
//        let i = article.articleImage
        self.addSubview(articleName)
        self.addSubview(articleImage)
        articleName.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self).offset(20)
        }
        articleImage.snp.makeConstraints { (make) in
            make.height.width.equalTo(self.frame.height)
            make.left.equalTo(self).offset(20)
        }
//        let url: URL = URL(fileURLWithPath: article.imageURL)
//        print(url)
//        i.af_setImage(withURL: url, placeholderImage: Constants.noImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.flipFromTop(5), runImageTransitionIfCached: false) { (res) in
//            print(res)
//        }
        if !article.imageURL.isEmpty {
//            let url = URL(string: String(article.imageURL))!
//            let placeholderImage = UIImage(named: "no-image")!
//
//            DispatchQueue.main.async {
//                i.af_setImage(
//                    withURL: url,
//                    placeholderImage: placeholderImage,
//                    filter: nil
//                )
//            }
            articleImage.loadImageUsingURLString(urlString: article.imageURL)
        }
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageURLString: String?
    
    func loadImageUsingURLString(urlString: String) {
        self.imageURLString = urlString
        
        let url = URL(string: urlString)!
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            print(imageFromCache)
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                self.image = nil
                if error != nil {
                    print(error.debugDescription)
                    self.image = Constants.noImage
                    return
                }
//            }
//            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                print(self.imageURLString == urlString)
                if self.imageURLString == urlString {
                    self.image = UIImage(data: data!)
                    imageCache.setObject(imageToCache as AnyObject, forKey: self.imageURLString as AnyObject)
                }
            }
        }).resume()
    }
}
