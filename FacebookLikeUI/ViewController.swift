//
//  ViewController.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/10/13.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    //ナビゲーションのアイテム
    fileprivate var helpButton: UIBarButtonItem!

    //スクロールの開始位置を格納する変数
    fileprivate var scrollBeginingPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //デリゲートの設定
        navigationController?.delegate = self

        //ナビゲーションと色設定
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        //タイトルテキスト用の色設定
        let attrs = [
            NSForegroundColorAttributeName : UIColor.gray,
            NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 15)!
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        
        //Buttonを設置
        helpButton = UIBarButtonItem(title: "Help", style: .plain, target: self, action: #selector(ViewController.helpButtonTapped(button:)))
        helpButton.setTitleTextAttributes(
            [
                NSForegroundColorAttributeName : UIColor.gray,
                NSFontAttributeName: UIFont(name: "Georgia-Bold", size: 13)!
            ], for: .normal)
        
        //タイトルを置く
        navigationItem.title = "Welcome To UITrace!"
        navigationItem.rightBarButtonItem = helpButton
        
    }
    
    //ヘルプボタンタップ時のメソッド
    func helpButtonTapped(button: UIButton) {
        print("Help button tapped")
    }
    
    /* (UIScrollViewDelegate) */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.scrollBeginingPoint = scrollView.contentOffset
    }

    /* (UIScrollViewDelegate) */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        
        //スクロール終了時のy座標を取得する
        let currentPoint = scrollView.contentOffset

        //下向きのスクロールを行った場合の処理
        if scrollBeginingPoint.y < currentPoint.y {
                
            navigationController?.setNavigationBarHidden(true, animated: true)

        //上向きのスクロールを行った場合の処理
        } else {
            
            navigationController?.setNavigationBarHidden(false, animated: true)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

