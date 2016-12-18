//
//  DetailController.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/18.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//詳細画像のセルに関する定数
struct DetailCellConfig {
    static let cellHeight = 280
}

class DetailController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    //UIパーツの配置
    @IBOutlet weak var detailTableView: UITableView!
    
    //表示対象の画像データ(UIImage一覧)
    var targetImageList: [UIImage] = []
    
    //カスタマイズヘッダーのメンバ変数 ※コメントアウト
    //var bounceHeaderView: CustomTableViewHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationControllerデリゲートと色やタイトル関連の設定
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.gray,
            NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 13)!
        ]
        self.navigationItem.title = "登録写真の縦方向への一覧表示"

        //UITableViewのデリゲート・データソースの設定
        detailTableView.delegate = self
        detailTableView.dataSource = self

        //サムネイル表示用のセルの読み込み
        let nibThumbnailTableView: UINib = UINib(nibName: "ThumbnailCell", bundle: nil)
        detailTableView.register(nibThumbnailTableView, forCellReuseIdentifier: "ThumbnailCell")
        
        //6枚目の位置から見えるように位置の調整を行う
        detailTableView.contentOffset.y = CGFloat(DetailCellConfig.cellHeight * (ImageConfig.maxPhotoCount - 1))

        //カスタマイズヘッダーの定義 ※コメントアウト
        //bounceHeaderView = CustomTableViewHeader.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 240))
        //detailTableView.tableHeaderView = bounceHeaderView
    }

    //テーブルの要素数を設定する ※必須
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //テーブルの行数を設定する ※必須
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetImageList.count
    }
    
    //表示するセルの中身を設定する ※必須
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbnailCell") as? ThumbnailCell
        
        let thumbnail = targetImageList[indexPath.row]
        let imageTitle = " 画像\(indexPath.row + 1)："
        
        cell?.thumbnailLabel.text = imageTitle
        cell?.thumbnailImage.image = thumbnail
        
        cell!.accessoryType = UITableViewCellAccessoryType.none
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }

    //テーブルのセル高さ ※任意
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(DetailCellConfig.cellHeight)
    }

    //カスタマイズヘッダーの制約を変更してバウンド効果をつける ※コメントアウト
    //func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //    bounceHeaderView.scrollViewDidScroll(scrollView)
    //}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
