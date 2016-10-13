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
    var helpButton: UIBarButtonItem!
    
    //1回だけ生成するためのフラグ（ViewDidLayoutSubViews内での初期配置用）
    private var onceFlag = false
    
    //スクロールの開始位置を格納する変数
    var scrollBeginingPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //識別用のタグ付け
        self.buttonScrollView.tag = Settings.menu.rawValue
        self.mainScrollView.tag = Settings.contents.rawValue
        
        //デリゲートの設定
        self.navigationController?.delegate = self
        self.mainScrollView.delegate = self

        //ナビゲーションと色設定
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        //タイトルテキスト用の色設定
        let attrs = [
            NSForegroundColorAttributeName : UIColor.gray,
            NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 15)!
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        
        //Buttonを設置
        self.helpButton = UIBarButtonItem(title: "Help", style: .plain, target: self, action: #selector(ViewController.helpButtonTapped(button:)))
        self.helpButton.setTitleTextAttributes(
            [
                NSForegroundColorAttributeName : UIColor.gray,
                NSFontAttributeName: UIFont(name: "Georgia-Bold", size: 13)!
            ], for: .normal)
        
        self.navigationItem.title = "Welcome To UITrace!"
        self.navigationItem.rightBarButtonItem = self.helpButton
        
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
        
        if self.onceFlag == false {
        
            //コンテンツ用のScrollViewを初期化
            self.initScrollViews()

            for i in 0...2 {
                
                //メニュー用のスクロールビューにボタンを配置
                let buttonElement: UIButton! = UIButton()
                self.buttonScrollView.addSubview(buttonElement)
                
                buttonElement.frame = CGRect(
                    x: Int(self.buttonScrollView.frame.width) / 3 * i,
                    y: 0,
                    width: Int(self.buttonScrollView.frame.width) / 3,
                    height: Int(self.buttonScrollView.frame.height)
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
            if self.scrollBeginingPoint.y < currentPoint.y {
                
                //自作メニューを隠して、変化量が40以上であればナビゲーションバーも一緒に隠す
                self.hideMenuScrollView()

                if currentPoint.y - self.scrollBeginingPoint.y > 40 {
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                }

            //上向きのスクロールを行った場合の処理
            } else {

                //自作メニューを表示して、変化量が40以上であればナビゲーションバーも一緒に表示
                self.showMenuScrollView()
                
                if self.scrollBeginingPoint.y - currentPoint.y > 40 {
                    self.navigationController?.setNavigationBarHidden(false, animated: true)
                }
 
            }
        }

    }
    
    //自作メニューを隠すメソッド（AutoLayoutの制約をいじるだけ）
    private func hideMenuScrollView() {

        self.topConstraint.constant = -64
        UIView.animate(withDuration: 0.26, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations:
            
            //変更したAutoLayoutのConstant値を適用する
            {
                self.view.layoutIfNeeded()
            }, completion: { finished in
            }
        )
    }
    
    //自作メニューを再表示するメソッド（AutoLayoutの制約をいじるだけ）
    private func showMenuScrollView() {

        self.topConstraint.constant = 0
        UIView.animate(withDuration: 0.26, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations:
            
            //変更したAutoLayoutのConstant値を適用する
            {
                self.view.layoutIfNeeded()
            }, completion: { finished in
            }
        )
    }
    
    //メインスクロールビューの初期化設定
    private func initScrollViews() {
        
        //各種プロパティ値を設定する
        self.mainScrollView.isPagingEnabled = false
        self.mainScrollView.isScrollEnabled = true
        self.mainScrollView.isDirectionalLockEnabled = true
        self.mainScrollView.showsHorizontalScrollIndicator = false
        self.mainScrollView.showsVerticalScrollIndicator = true
        self.mainScrollView.bounces = true
        self.mainScrollView.scrollsToTop = false
        
        //メインスクロールビューの中コンテンツの高さを設定する
        self.mainScrollView.contentSize = CGSize(
            width: Int(self.mainScrollView.frame.width),
            height: Int(self.mainScrollView.frame.height) * 2
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

