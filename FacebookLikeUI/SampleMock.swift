//
//  SampleMock.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/19.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

struct SampleMock {
    
    static func getSampleList() -> [Sample] {
        
        var models: [Sample] = []

        //サンプルデータを投入する（画像の設定を変えてお試し下さい）
        var imageList1: [UIImage] = [UIImage]()
        var imageList2: [UIImage] = [UIImage]()
        var imageList3: [UIImage] = [UIImage]()

        let image1 = UIImage(named: "image1")!
        let image2 = UIImage(named: "image2")!
        let image3 = UIImage(named: "image3")!
        let image4 = UIImage(named: "image4")!
        let image5 = UIImage(named: "image5")!
        let image6 = UIImage(named: "image6")!
        let image7 = UIImage(named: "image7")!

        let image8  = UIImage(named: "image8")!
        let image9  = UIImage(named: "image9")!
        let image10 = UIImage(named: "image10")!
        let image11 = UIImage(named: "image11")!
        let image12 = UIImage(named: "image12")!

        let image13 = UIImage(named: "image13")!
        let image14 = UIImage(named: "image14")!
        let image15 = UIImage(named: "image15")!
        let image16 = UIImage(named: "image16")!
        let image17 = UIImage(named: "image17")!
        let image18 = UIImage(named: "image18")!
        
        imageList1.append(image1)
        imageList1.append(image2)
        imageList1.append(image3)
        imageList1.append(image4)
        imageList1.append(image5)
        imageList1.append(image6)
        imageList1.append(image7)
        imageList1.append(image8)

        imageList2.append(image9)
        imageList2.append(image10)
        imageList2.append(image11)
        imageList2.append(image12)

        imageList3.append(image13)
        imageList3.append(image14)
        imageList3.append(image15)
        imageList3.append(image16)
        imageList3.append(image17)
        imageList3.append(image18)

        models.append(
            Sample(
                title: "今回のサンプルの説明",
                catchcopy: "Facebookと似たタイル状レイアウトサンプル",
                description: "今回はFacebookライクな画像の配置方法の例になります。AutoLayoutとクロージャーを使用した仕方を是非マスターしてみると面白いと思います。",
                imageArray: imageList1,
                datetime: "2016/12/20"
            )
        )
        models.append(
            Sample(
                title: "このサンプルのポイント",
                catchcopy: "AutoLayoutの制約の変更と優先度",
                description: "Xibに切り出したTableViewのセル内に画像を配置していきます。位置に関するAutoLayoutをあらかじめ配置しておき、幅と高さの制約をOutletに切り出します。そして幅と高さの制約については優先度を下げておくのがポイントになります。",
                imageArray: imageList2,
                datetime: "2016/12/20"
            )
        )
        models.append(
            Sample(
                title: "画像をタップすると該当の画像を表示",
                catchcopy: "クロージャーと画像のGestureRecognizerを利用",
                description: "画像サムネイルをタップした際は横スクロールの表示画面で該当画像の位置から表示できるようにします。また6枚以上の画像がある際に表示されるボタンを押した場合には、縦の一覧表示をする形にしています。",
                imageArray: imageList3,
                datetime: "2016/12/20"
            )
        )
        return models
    }
}
