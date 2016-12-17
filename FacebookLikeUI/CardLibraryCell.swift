//
//  CardLibraryCell.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/12.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//設定用の定数
struct CardLibraryConst {
    let sectionCount = 1
    let itemCount = 12
}

class CardLibraryCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    //UIパーツの配置
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //CollectionViewのデリゲート・データソースの設定
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        
        //画像のセルを定義する
        let nibCardCell: UINib = UINib(nibName: "CardCell", bundle: nil)
        cardCollectionView.register(nibCardCell, forCellWithReuseIdentifier: "CardCell")
    }

    /* (UICollectionViewDelegate) */
    
    //このコレクションビューのセクション数を決める
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CardLibraryConst().sectionCount
    }
    
    /* (UICollectionViewDataSource) */
    
    //このコレクションビューのセル数を決める
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CardLibraryConst().itemCount
    }
    
    //このコレクションビューのセル内へ写真の配置を行う
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell
        return cell!
    }
    
    //このコレクションビューのセルをタップした際の写真を選択する
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //TODO: 選択したセル要素を取得して何かしらの処理をする
        //let selectedCell = collectionView.cellForItem(at: indexPath) as? CardCell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
