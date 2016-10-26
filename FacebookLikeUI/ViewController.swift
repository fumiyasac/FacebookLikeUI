//
//  ViewController.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/10/13.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//スクロールビューの識別用タグの値
enum Settings: Int {
    case menu = 1
    case contents
}

class ViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {

    //自作ナビゲーションのスクロールビュー
    @IBOutlet weak var buttonScrollView: UIScrollView!

    //メインのスクロールビュー
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    //コンテンツ一番上の制約
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    //ナビゲーションのアイテム
    fileprivate var helpButton: UIBarButtonItem!
    
    //1回だけ生成するためのフラグ（ViewDidLayoutSubViews内での初期配置用）
    fileprivate var onceFlag = false
    
    //スクロールの開始位置を格納する変数
    fileprivate var scrollBeginingPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //識別用のタグ付け
        buttonScrollView.tag = Settings.menu.rawValue
        mainScrollView.tag = Settings.contents.rawValue
        
        //デリゲートの設定
        navigationController?.delegate = self
        mainScrollView.delegate = self

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
        
        navigationItem.title = "Welcome To UITrace!"
        navigationItem.rightBarButtonItem = self.helpButton
        
    }
    
    //ヘルプボタンタップ時のメソッド
    func helpButtonTapped(button: UIButton) {
        print("Help button tapped")
    }

    //ナビゲーションボタンタップ時のメソッド
    func naviButtonTapped(button: UIButton) {
        print("Navi button \(button.tag) tapped")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if onceFlag == false {
        
            //コンテンツ用のScrollViewを初期化
            initScrollViews()

            for i in 0...2 {
                
                //メニュー用のスクロールビューにボタンを配置
                let buttonElement: UIButton! = UIButton()
                buttonScrollView.addSubview(buttonElement)
                
                buttonElement.frame = CGRect(
                    x: Int(buttonScrollView.frame.width) / 3 * i,
                    y: 0,
                    width: Int(buttonScrollView.frame.width) / 3,
                    height: Int(buttonScrollView.frame.height)
                )
                buttonElement.backgroundColor = UIColor.gray
                buttonElement.setTitle("サンプル\(i)", for: .normal)
                buttonElement.titleLabel!.font = UIFont.systemFont(ofSize: 13)
                buttonElement.tag = i
                buttonElement.addTarget(self, action: #selector(ViewController.naviButtonTapped(button:)), for: .touchUpInside)
                
            }

            self.onceFlag = true
        }
    }
    
    // -- scrollViewWillBeginDragging(UIScrollViewDelegate) --
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if scrollView.tag == Settings.contents.rawValue {
            self.scrollBeginingPoint = scrollView.contentOffset
        }
        
    }

    // -- scrollViewDidScroll(UIScrollViewDelegate) --
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.tag == Settings.contents.rawValue {
            
            //スクロール終了時のy座標を取得する
            let currentPoint = scrollView.contentOffset

            //下向きのスクロールを行った場合の処理
            if scrollBeginingPoint.y < currentPoint.y {
                
                //自作メニューを隠して、変化量が40以上であればナビゲーションバーも一緒に隠す
                hideMenuScrollView()

                if currentPoint.y - self.scrollBeginingPoint.y > 40 {
                    navigationController?.setNavigationBarHidden(true, animated: true)
                
                }

            //上向きのスクロールを行った場合の処理
            } else {

                //自作メニューを表示して、変化量が40以上であればナビゲーションバーも一緒に表示
                showMenuScrollView()
                
                if scrollBeginingPoint.y - currentPoint.y > 40 {
                    navigationController?.setNavigationBarHidden(false, animated: true)
                }
 
            }
        }

    }
    
    //自作メニューを隠すメソッド（AutoLayoutの制約をいじるだけ）
    fileprivate func hideMenuScrollView() {

        topConstraint.constant = -64
        UIView.animate(withDuration: TimeInterval(UINavigationControllerHideShowBarDuration), delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations:
            
            //変更したAutoLayoutのConstant値を適用する
            {
                self.view.layoutIfNeeded()
            }, completion: { finished in
            }
        )
    }
    
    //自作メニューを再表示するメソッド（AutoLayoutの制約をいじるだけ）
    fileprivate func showMenuScrollView() {

        topConstraint.constant = 0
        UIView.animate(withDuration: TimeInterval(UINavigationControllerHideShowBarDuration), delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations:
            
            //変更したAutoLayoutのConstant値を適用する
            {
                self.view.layoutIfNeeded()
            }, completion: { finished in
            }
        )
    }
    
    //メインスクロールビューの初期化設定
    fileprivate func initScrollViews() {
        
        //各種プロパティ値を設定する
        mainScrollView.isPagingEnabled = false
        mainScrollView.isScrollEnabled = true
        mainScrollView.isDirectionalLockEnabled = true
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.showsVerticalScrollIndicator = true
        mainScrollView.bounces = true
        mainScrollView.scrollsToTop = false
        
        //メインスクロールビューの中コンテンツの高さを設定する
        mainScrollView.contentSize = CGSize(
            width: Int(mainScrollView.frame.width),
            height: Int(mainScrollView.frame.height) * 2
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

