//
//  ImageController.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/18.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ImageController: UIViewController, UIScrollViewDelegate {

    //UIパーツの配置
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    //表示対象の画像データ(UIImage一覧)
    var targetImageList: [UIImage] = []

    //初期表示対象の画像データのインデックス
    var targetImageCount: Int = 0
    
    //再配置防止用のフラグ
    fileprivate var onceFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIScrollViewのデリゲート
        imageScrollView.delegate = self
        
        //初回呼び出し時にはコンテンツ全体を非表示状態にしておく
        self.view.alpha = 0.0
    }

    //Viewの表示が完了した際に呼び出されるメソッド
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //ポップアップ表示を実行する
        showAnimatePopup()
    }

    //レイアウト処理が完了した際のライフサイクル
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if onceFlag == false {
            
            //コンテンツ用のScrollViewを初期化
            initScrollViewDefinition()
            
            //写真の枚数を元にスクロールビューの横幅を決定する
            let imageScrollWidth: CGFloat = CGFloat(Int(imageScrollView.frame.width) * targetImageList.count)
            
            //スクロールビュー内のサイズを決定する（AutoLayoutで配置を行った場合でもこの部分はコードで設定しないといけない）
            imageScrollView.contentSize = CGSize(
                width:  imageScrollWidth,
                height: imageScrollView.frame.height
            )
            
            //スクロールビューの中に画像を横一列に並べて配置する
            for i in 0...(targetImageList.count - 1) {
                
                //メニュー用のスクロールビューにUIImageViewを配置
                let imageView: UIImageView = UIImageView()
                imageView.image = targetImageList[i]
                imageScrollView.addSubview(imageView)
                imageView.frame = CGRect(
                    x: CGFloat(Int(imageScrollView.frame.width) * i),
                    y: 0,
                    width: imageScrollView.frame.width,
                    height: imageScrollView.frame.height
                )
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
            }

            //スクロールの初期位置を設定する
            imageCountLabel.text = "Page \(targetImageCount) / \(targetImageList.count)"
            imageScrollView.contentOffset.x = CGFloat(Int(imageScrollView.frame.width) * (targetImageCount - 1))

        }
        onceFlag = true
    }

    //慣性スクロールの減速が止まった際に行われる処理
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        //現在表示されているページ番号を判別する
        let pageWidth = imageScrollView.frame.width
        let fractionalPage = Double(imageScrollView.contentOffset.x / pageWidth)
        
        //停止時の画像位置を表示する
        let page = lround(fractionalPage) + 1
        imageCountLabel.text = "Page \(page) / \(targetImageList.count)"
    }

    //ポップアップを閉じる処理
    @IBAction func imageCloseAction(_ sender: UIButton) {
        removeAnimatePopup()
    }

    /* (Fileprivate functions) */
    
    //コンテンツ用のUIScrollViewの初期化を行う
    fileprivate func initScrollViewDefinition() {
        
        //スクロールビュー内の各プロパティ値を設定する
        imageScrollView.isPagingEnabled = true
        imageScrollView.isScrollEnabled = true
        imageScrollView.isDirectionalLockEnabled = false
        imageScrollView.showsHorizontalScrollIndicator = true
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.bounces = false
        imageScrollView.scrollsToTop = false
    }
    
    //ポップアップアニメーションを実行する
    fileprivate func showAnimatePopup() {
        UIView.animate(withDuration: 0.16, animations: {
            
            //おおもとのViewのアルファ値を1.0にして拡大比率を元に戻す
            self.view.alpha = 1.0
        })
    }

    //ポップアップアニメーションを閉じる（実行するまではアルファが1でこのUIViewControllerが等倍の状態）
    fileprivate func removeAnimatePopup() {
        UIView.animate(withDuration: 0.16, animations: {
            
            //おおもとのViewのアルファ値を0.0にして拡大比率を拡大した状態に変更
            self.view.alpha = 0.0
            
        }, completion:{ finished in
            
            //アニメーションが完了した際に遷移元に戻す
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
