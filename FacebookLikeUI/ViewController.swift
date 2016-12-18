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
}

class ViewController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //コンテンツリスト表示用のTableView
    @IBOutlet weak var contentsTableView: UITableView!

    var models: [Sample] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavigationControllerデリゲートと色やタイトル関連の設定
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.gray,
            NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 13)!
        ]
        self.navigationItem.title = "Facebookを意識したレイアウトサンプル"
        
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
        
        models = SampleMock.getSampleList()
    }
    
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
            return models.count
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

            let model = models[indexPath.row]

            //文字データ・画像データをセルに表示する
            cell.contentsTitle.text = model.title
            cell.contentsSubTitle.text = model.catchcopy
            cell.contentsDate.text = model.datetime
            cell.contentsDescription.text = model.description

            let imageList: [UIImage] = model.imageArray
            cell.setImageViews(images: imageList)
            
            //MainContentsCell側に設定したクロージャーの内部の処理を記載する
            cell.transitionClosure = { [weak self] num in
                
                if num != nil {
                    
                    //MainContentsCell側の画像がタップがされた場合は該当画像の表示をポップアップで行う
                    let toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageController") as! ImageController
                    toVC.targetImageList = imageList
                    toVC.targetImageCount = num!
                    self?.present(toVC, animated: false, completion: nil)
                    
                } else {
                    
                    //MainContentsCell側のボタンがタップがされた場合は画像一覧の表示を行う
                    let toVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailController") as! DetailController
                    toVC.targetImageList = imageList
                    self?.navigationController?.pushViewController(toVC, animated: true)
                }

            }
            
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
        print("Cell number: \(indexPath.row)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

