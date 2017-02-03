//
//  AppCell.swift
//  appStore
//
//  Created by Edward on 2/2/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {
    
    // MARK: Initalization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    var app: App? {
        didSet {
            if let app = app {
                if let imageName = app.imageName {
                    imageView.image = UIImage(named: imageName)
                }
                if let name = app.name {
                    nameLabel.text = name
                    // Recalibrate frames here because when app is scrolled out of view app loses frame
                    nameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 30)
                    // Checks to see if line wraps by passing in the exact fonts and attribuites for uilabel
                    let rect = NSString(string: name).boundingRect(with: CGSize(width: frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 11)], context: nil)
                    
                    // If the name label is multiline
                    if rect.height > 20 {
                        categoryLabel.frame = CGRect(x: 0, y: nameLabel.frame.maxY, width: frame.width, height: 10)
                        priceLabel.frame = CGRect(x: 0, y: categoryLabel.frame.maxY + 2, width: frame.width, height: 10)
                    } else {
                        categoryLabel.frame = CGRect(x: 0, y: nameLabel.frame.maxY - 15, width: frame.width, height: 10)
                        priceLabel.frame = CGRect(x: 0, y: categoryLabel.frame.maxY + 2, width: frame.width, height: 10)
                    }
                    
                    nameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 30)
                    nameLabel.sizeToFit()
                }
                if let category = app.category {
                    categoryLabel.text = category
                }
                if let price = app.price {
                    priceLabel.text = "$\(String(describing: price))"
                }
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "@#@$%#%$#^%$^$^%$^"
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "$%^$^%$&&%"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 30)
        categoryLabel.frame = CGRect(x: 0, y: nameLabel.frame.maxY, width: frame.width, height: 10)
        priceLabel.frame = CGRect(x: 0, y: categoryLabel.frame.maxY + 2, width: frame.width, height: 10)
    }
}

