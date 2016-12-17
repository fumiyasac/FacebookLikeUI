//
//  MainContentsCell.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/12.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//デバイスの横幅を取得するための構造体
struct DeviceSize {
    
    //デバイスの画面の横サイズを取得
    static func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
}

class MainContentsCell: UITableViewCell {

    //UIパーツの配置
    @IBOutlet weak var contentsTitle: UILabel!
    @IBOutlet weak var contentsSubTitle: UILabel!
    @IBOutlet weak var contentsDescription: UITextView!

    @IBOutlet weak var contentsImage1: UIImageView!
    @IBOutlet weak var contentsImage2: UIImageView!
    @IBOutlet weak var contentsImage3: UIImageView!
    @IBOutlet weak var contentsImage4: UIImageView!
    @IBOutlet weak var contentsImage5: UIImageView!
    @IBOutlet weak var contentsImage6: UIImageView!

    @IBOutlet weak var contentsDate: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreCount: UILabel!
    
    //それぞれ画像の制約に関する設定(Width/Height)
    @IBOutlet weak fileprivate var contentImage1Width: NSLayoutConstraint!
    @IBOutlet weak fileprivate var contentImage1Height: NSLayoutConstraint!
    
    @IBOutlet weak fileprivate var contentImage2Width: NSLayoutConstraint!
    @IBOutlet weak fileprivate var contentImage2Height: NSLayoutConstraint!
    
    @IBOutlet weak fileprivate var contentImage3Width: NSLayoutConstraint!
    @IBOutlet weak fileprivate var contentImage3Height: NSLayoutConstraint!
    
    @IBOutlet weak fileprivate var contentImage4Width: NSLayoutConstraint!
    @IBOutlet weak fileprivate var contentImage4Height: NSLayoutConstraint!

    @IBOutlet weak fileprivate var contentImage5Width: NSLayoutConstraint!
    @IBOutlet weak fileprivate var contentImage5Height: NSLayoutConstraint!
    
    @IBOutlet weak fileprivate var contentImage6Width: NSLayoutConstraint!
    @IBOutlet weak fileprivate var contentImage6Height: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //TEST: 画像の制約を動的に変更するテスト
        setLayoutConstraintSetting(count: 6)
    }

    //AutoLayoutの制約を画像枚数に応じて設定するメソッド
    func setLayoutConstraintSetting(count: Int) {
        
        //もっと見るボタンに関しては5枚より多い場合に表示するので初期状態では無効化
        moreButton.isEnabled = false
        moreButton.alpha = 0
        moreCount.isEnabled = false
        moreCount.alpha = 0

        //各配置済のImageViewのConstraintにおいて、幅と高さの優先度を下げる
        downConstraintPriority()
        
        //この部分はもうちょっとエレガントに書けないか...
        switch count {
        
        case 0:

            let mainRectWidth: CGFloat   = CGFloat(DeviceSize.screenWidth() - 30)
            
            contentImage1Height.constant = 0
            contentImage1Width.constant  = mainRectWidth
            
            contentImage2Height.constant = 0
            contentImage2Width.constant  = 0
            
            contentImage3Height.constant = 0
            contentImage3Width.constant  = contentImage1Width.constant
            
            contentImage4Height.constant = 0
            contentImage4Width.constant  = 0
            
            contentImage5Height.constant = 0
            contentImage5Width.constant  = contentImage1Width.constant
            
            contentImage6Height.constant = 0
            contentImage6Width.constant  = 0
            
            self.layoutIfNeeded()
            
        case 1:
            
            let mainRectWidth: CGFloat   = CGFloat(DeviceSize.screenWidth() - 30)
            let mainRectHeight: CGFloat  = 180
            
            contentImage1Height.constant = mainRectHeight
            contentImage1Width.constant  = mainRectWidth
            
            contentImage2Height.constant = mainRectHeight
            contentImage2Width.constant  = 0
            
            contentImage3Height.constant = 0
            contentImage3Width.constant  = mainRectWidth
            
            contentImage4Height.constant = 0
            contentImage4Width.constant  = 0
            
            contentImage5Height.constant = contentImage3Height.constant
            contentImage5Width.constant  = contentImage3Width.constant
            
            contentImage6Height.constant = contentImage4Height.constant
            contentImage6Width.constant  = contentImage4Width.constant
            
            self.layoutIfNeeded()

        case 2:

            let mainRect: CGFloat = CGFloat(DeviceSize.screenWidth() - 30) / 2
            
            contentImage1Height.constant = mainRect
            contentImage1Width.constant  = mainRect
            
            contentImage2Height.constant = mainRect
            contentImage2Width.constant  = mainRect
            
            contentImage3Height.constant = 0
            contentImage3Width.constant  = mainRect
            
            contentImage4Height.constant = 0
            contentImage4Width.constant  = mainRect
            
            contentImage5Height.constant = contentImage3Height.constant
            contentImage5Width.constant  = contentImage3Width.constant
            
            contentImage6Height.constant = contentImage4Height.constant
            contentImage6Width.constant  = contentImage4Width.constant
            
            self.layoutIfNeeded()

        case 3:
            
            let subRect: CGFloat = 100
            let mainRectWidth: CGFloat = CGFloat(DeviceSize.screenWidth() - subRect - 30)
            let mainRectHeight: CGFloat = CGFloat(subRect * 2)
            
            contentImage1Height.constant = mainRectHeight
            contentImage1Width.constant  = mainRectWidth
            
            contentImage2Height.constant = subRect
            contentImage2Width.constant  = subRect
            
            contentImage3Height.constant = 0
            contentImage3Width.constant  = mainRectWidth
            
            contentImage4Height.constant = subRect
            contentImage4Width.constant  = subRect
            
            contentImage5Height.constant = 0
            contentImage5Width.constant  = mainRectWidth
            
            contentImage6Height.constant = 0
            contentImage6Width.constant  = subRect
            
            self.layoutIfNeeded()

        case 4:
            
            let mainRect: CGFloat = CGFloat(DeviceSize.screenWidth() - 30) / 2
            
            contentImage1Height.constant = mainRect
            contentImage1Width.constant  = mainRect
            
            contentImage2Height.constant = mainRect
            contentImage2Width.constant  = mainRect
            
            contentImage3Height.constant = mainRect
            contentImage3Width.constant  = mainRect
            
            contentImage4Height.constant = mainRect
            contentImage4Width.constant  = mainRect
            
            contentImage5Height.constant = 0
            contentImage5Width.constant  = mainRect
            
            contentImage6Height.constant = 0
            contentImage6Width.constant  = mainRect
            
            self.layoutIfNeeded()
            
        default:
            
            let photoAreaWidth: CGFloat = CGFloat(DeviceSize.screenWidth() - 30)
            let subRect: CGFloat = 100
            let mainRectWidth: CGFloat = photoAreaWidth - subRect
            let mainRectHeight: CGFloat = (subRect * 3) / 2
            
            contentImage1Height.constant = mainRectHeight
            contentImage1Width.constant = mainRectWidth
            
            contentImage2Height.constant = subRect
            contentImage2Width.constant = subRect
            
            contentImage3Height.constant = contentImage1Height.constant
            contentImage3Width.constant = contentImage1Width.constant
            
            contentImage4Height.constant = contentImage2Height.constant
            contentImage4Width.constant = contentImage2Height.constant
            
            contentImage5Height.constant = 0
            contentImage5Width.constant = contentImage1Width.constant
            
            contentImage6Height.constant = contentImage2Height.constant
            contentImage6Width.constant = contentImage2Height.constant
            
            self.layoutIfNeeded()

            //ボタンを有効化する
            moreButton.isEnabled = true
            moreButton.alpha = 0.45
            moreCount.isEnabled = true
            moreCount.alpha = 1
        }
    }
    
    //TODO: サムネイルに該当のGestureRecognizerをつける
    
    //「もっと他の画像を見る」ボタンのアクション
    @IBAction func moreImageAction(_ sender: UIButton) {
        print("moreImageAction Tapped.")
    }
    
    
    //配置しているUIImageViewの幅と高さの制約の優先度を下げる
    fileprivate func downConstraintPriority() {

        let targetConstraintSet: [NSLayoutConstraint] = [
            contentImage1Width,
            contentImage1Height,
            contentImage2Width,
            contentImage2Height,
            contentImage3Width,
            contentImage3Height,
            contentImage4Width,
            contentImage4Height,
            contentImage5Width,
            contentImage5Height,
            contentImage6Width,
            contentImage6Height,
        ]

        for (_, targetConstraint) in targetConstraintSet.enumerated() {
            targetConstraint.priority = UILayoutPriority(750)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
