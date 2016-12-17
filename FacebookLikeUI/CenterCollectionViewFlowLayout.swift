//
//  CenterCollectionViewFlowLayout.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/17.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

/**
 * UICollectionViewを水平方向に動かした際にセルの中央位置で止まるようにするクラス
 * UICollectionViewFlowLayoutを継承したサブクラスを作成してカスタマイズする
 * ※ InterfaceBuilderでUICollectionViewFlowLayoutの「Custom Class」の部分をこのクラスに変更する
 *
 */
class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    /**
     * targetContentOffsetメソッド
     * proposedContentOffset: スクロールの早さから推測される停止位置
     * velocity: 1秒あたりの移動距離 (単位:ポイント)
     *
     * 参考資料1: [iOS] UICollectionView のレイアウトクラスを作成して「左右のアイテムをチラ見せするレイアウト」を実現する
     * 参考資料1はObjective-Cではあるがオーバーライドをしているメソッドの引数や返り値は同じ
     * http://dev.classmethod.jp/smartphone/iphone/collection-view-layout-cell-snap/
     *
     * 参考資料2: iOS UICollecionViewFlowLayout でカスタムレイアウトを作ろう 〜 Swift版
     * UICollectionViewLayoutAttributesに関しては下記を説明を参考にしてみて下さい
     * http://www.indetail.co.jp/blog/5257/
     *
     */
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        if let targetCollectionView = self.collectionView {
            
            //proposedContentOffsetにCollectionViewの幅の半分を加算してセルの停止位置を決める
            let targetCollectionViewBounds = targetCollectionView.bounds
            let halfWidth = targetCollectionViewBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
            
            //変数：targetCollectionViewBoundsの要素のレイアウト情報の配列を取得する
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: targetCollectionViewBounds) {
                
                //位置の補正対象候補となる要素のレイアウト情報を格納する変数
                var candidateAttributes : UICollectionViewLayoutAttributes?
                
                //位置の補正対象候補となる要素のレイアウト情報を探す
                for attributes in attributesForVisibleCells {
                    
                    //要素がCollectionViewCell以外の場合は処理を中断して次のループ要素へ
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    
                    //要素のレイアウト情報で中心位置がCollectionViewの表示エリア外の場合は処理を中断して次のループ要素へ
                    if (attributes.center.x == 0) || (attributes.center.x > (targetCollectionView.contentOffset.x + halfWidth) && velocity.x < 0) {
                        continue
                    }

                    //candidateAttributesがnilならば変数：candidateAttributesに現在のレイアウト情報を入れる
                    guard let candAttrs = candidateAttributes else {
                        candidateAttributes = attributes
                        continue
                    }
                    
                    //位置の補正対象候補のレイアウト情報とループで取得されたレイアウト情報を比較して候補となる値を変更する
                    let a = attributes.center.x - proposedContentOffsetCenterX
                    let b = candAttrs.center.x - proposedContentOffsetCenterX
                    
                    if fabsf(Float(a)) < fabsf(Float(b)) {
                        candidateAttributes = attributes
                    }
                }
                
                //一番最初のセルが表示されている or 初期状態の時に左にスクロールをした際の考慮(ないとnilで落ちてしまう)
                if proposedContentOffset.x == -(targetCollectionView.contentInset.left) {
                    return proposedContentOffset
                }

                //X軸方向の値を変更して、CollectionViewの表示エリアの真ん中に来るように位置補正をする
                return CGPoint(x: floor(candidateAttributes!.center.x - halfWidth), y: proposedContentOffset.y)
            }
            
        }
        
        //CollectionViewからの値がない場合は継承元のメソッドにそのままproposedContentOffsetの値を入れる
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }

}
