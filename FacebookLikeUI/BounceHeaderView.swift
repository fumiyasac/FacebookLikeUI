//
//  BounceHeaderView.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/18.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class BounceHeaderView: UIView {
    
    @IBOutlet weak var bounceImageView: UIImageView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    class func instanceFromNib() -> BounceHeaderView {
        
        let view = UINib(nibName: "BounceHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BounceHeaderView
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
        //return UINib(nibName: "BounceHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BounceHeaderView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        topConstraint.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        bounceImageView.clipsToBounds = offsetY <= 0
        bottomConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        heightConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)        
    }
    
}
