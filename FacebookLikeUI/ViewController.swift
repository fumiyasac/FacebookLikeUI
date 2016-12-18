//
//  ViewController.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/10/13.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//設定用の定数
struct TableViewConst {
    let sectionCount = 3
    let itemCountOfCollection = 1
    let itemCountOfList = 10
}

class ViewController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //コンテンツリスト表示用のTableView
    @IBOutlet weak var contentsTableView: UITableView!
    
    //ナビゲーションのアイテム
    fileprivate var helpButton: UIBarButtonItem!

    //スクロールの開始位置を格納する変数
    fileprivate var scrollBeginingPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationControllerデリゲートと色やタイトル関連の設定
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.gray,
            NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 13)!
        ]
        self.navigationItem.title = "Welcome To UI Trace Like FB!"
        
        //UITableViewのデリゲート・データソースの設定
        contentsTableView.delegate = self
        contentsTableView.dataSource = self

        //セルの高さの予測値を設定する（高さが可変になる場合のセルが存在する場合）
        contentsTableView.rowHeight = UITableViewAutomaticDimension
        contentsTableView.estimatedRowHeight = 10000
        
        //Xibのクラスを読み込む宣言を行う
        let nibCardTableView: UINib = UINib(nibName: "CardLibraryCell", bundle: nil)
        let nibPhotoTableView: UINib = UINib(nibName: "PhotoLibraryCell", bundle: nil)
        let nibContentsTableView: UINib = UINib(nibName: "MainContentsCell", bundle: nil)

        contentsTableView.register(nibCardTableView, forCellReuseIdentifier: "CardLibraryCell")
        contentsTableView.register(nibPhotoTableView, forCellReuseIdentifier: "PhotoLibraryCell")
        contentsTableView.register(nibContentsTableView, forCellReuseIdentifier: "MainContentsCell")
    }
    
    /* (Instance Methods) */
    

    /* (UITableViewDelegate) */
    
    //テーブルビューのセクション数を決める
    func numberOfSections(in tableView: UITableView) -> Int {

        return TableViewConst().sectionCount
    }
    
    /* (UITableViewDataSource) */
    
    //テーブルビューのセクション内におけるセル数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section < 2 {
            return TableViewConst().itemCountOfCollection
        } else {
            return TableViewConst().itemCountOfList
        }
    }
    
    //テーブルビューのセル設定を行う
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardLibraryCell") as! CardLibraryCell
            
            cell.accessoryType = UITableViewCellAccessoryType.none
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoLibraryCell") as! PhotoLibraryCell
            
            cell.accessoryType = UITableViewCellAccessoryType.none
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainContentsCell") as! MainContentsCell

            cell.accessoryType = UITableViewCellAccessoryType.none
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            return cell!
        }
    }
    
    //セルがタップされた際の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
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

