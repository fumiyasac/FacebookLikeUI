//
//  CustomTableViewHeader.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/18.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

/* バウンドするヘッダーに関する設定(このあたりは後で解説をする) */
class CustomTableViewHeader: UIView {

    var heightLayoutConstraint = NSLayoutConstraint()
    var bottomLayoutConstraint = NSLayoutConstraint()
    
    var containerView = UIView()
    var containerLayoutConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.white
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.red

        self.addSubview(containerView)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : containerView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["containerView" : containerView]))
        
        containerLayoutConstraint = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        self.addConstraint(containerLayoutConstraint)
        
        let imageView: UIImageView = UIImageView.init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "onigiri")
        
        containerView.addSubview(imageView)

        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : imageView]))
        
        bottomLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        containerView.addConstraint(bottomLayoutConstraint)

        heightLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1.0, constant: 0.0)
        containerView.addConstraint(heightLayoutConstraint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        containerLayoutConstraint.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }

}
