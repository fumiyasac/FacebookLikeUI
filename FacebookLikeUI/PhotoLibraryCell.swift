//
//  PhotoLibraryCell.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/12.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit
import Photos

class PhotoLibraryCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    //PhotoLibraryで取得した画像を格納する配列
    var photoAssetLists: [PHAsset] = []
    
    //サムネイルを格納する配列
    var thumbnailLists: [UIImageView] = []
    
    //UIパーツの配置
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var photoSyncButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
        //ボタンに角丸をつける
        photoSyncButton.layer.cornerRadius = 5.0
        
        //画像のセルを定義する
        let nibPhotoCell: UINib = UINib(nibName: "PhotoCell", bundle: nil)
        photoCollectionView.register(nibPhotoCell, forCellWithReuseIdentifier: "PhotoCell")
        
        //画像をフォトライブラリから読み込む
        dispatchPhotoLibraryAndReload()
    }
    
    /* (UICollectionViewDelegate) */
    
    //このコレクションビューのセクション数を決める
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /* (UICollectionViewDataSource) */
    
    //このコレクションビューのセル数を決める
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAssetLists.count
    }
    
    //このコレクションビューのセル内へ写真の配置を行う
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell
        
        //cellへの画像表示
        cell?.photoImageView.image = convertAssetThumbnail(asset: photoAssetLists[indexPath.row], rectSize: 100)
        
        UIView.animate(withDuration: 0.28, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations:{
                cell?.photoImageView.alpha = 1
            }, completion: nil)
        
        return cell!
    }
    
    //このコレクションビューのセルをタップした際の写真を選択する
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //TODO: 選択したセル要素を取得して何かしらの処理をする
        //let selectedCell = collectionView.cellForItem(at: indexPath) as? PhotoCell
    }
    
    //画像を同期するアクション
    @IBAction func photoSyncAction(_ sender: UIButton) {
        
        //画像のアセットリストを一旦クリアして再度写真データを読み込む
        photoAssetLists.removeAll()
        dispatchPhotoLibraryAndReload()
    }

    //フォトライブラリを非同期で読み込む処理
    fileprivate func dispatchPhotoLibraryAndReload() {

        //データの取得はサブスレッドで行う
        DispatchQueue.global().async {
            self.photoCollectionView.isUserInteractionEnabled = false
            self.getPHAssetsForImageLibrary()
            
            //コレクションビューのリロードはメインスレッドで行う
            DispatchQueue.main.async {
                self.photoCollectionView.isUserInteractionEnabled = true
                self.photoCollectionView.reloadData()
            }
        }
    }

    //PHAssetクラスを使用して画像を取得する
    fileprivate func getPHAssetsForImageLibrary() {
        
        //データの並べ替え条件
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: true)
        ]
        
        //Photoライブラリから画像を取得する
        let assets: PHFetchResult = PHAsset.fetchAssets(with: .image, options: options)
        assets.enumerateObjects( { (asset, index, stop) -> Void in
            self.photoAssetLists.append(asset as PHAsset)
        })
        photoAssetLists.reverse()
    }

    //PHAsset型のデータを表示用に変換する
    fileprivate func convertAssetThumbnail(asset: PHAsset, rectSize: Int) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: rectSize, height: rectSize), contentMode: .aspectFill, options: option, resultHandler: {(result, info) -> Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
