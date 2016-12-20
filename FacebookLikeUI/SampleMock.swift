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

        //サンプルデータ表示用の配列（画像名のバリエーションを変えてお試しください）
        let imagePattern1: [UIImage] = getMockImageList(
            imageNameList: ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image29", "image30"]
        )
        let imagePattern2: [UIImage] = getMockImageList(
            imageNameList: ["image8", "image9", "image10", "image11", "image12"]
        )
        let imagePattern3: [UIImage] = getMockImageList(
            imageNameList: ["image13", "image14", "image15", "image16", "image17", "image18"]
        )
        let imagePattern4: [UIImage] = getMockImageList(
            imageNameList: ["image19", "image20", "image21"]
        )
        let imagePattern5: [UIImage] = getMockImageList(
            imageNameList: ["image22"]
        )
        let imagePattern6: [UIImage] = getMockImageList(
            imageNameList: ["image23", "image24"]
        )
        let imagePattern7: [UIImage] = getMockImageList(
            imageNameList: ["image25", "image26", "image27", "image28"]
        )

        models.append(
            Sample(
                title: "今回のサンプルの説明",
                catchcopy: "Facebookと似たタイル状レイアウトサンプル",
                description: "今回はFacebookライクな画像の配置方法の例になります。AutoLayoutとクロージャーを使用した仕方を是非マスターしてみると面白いと思います。",
                imageArray: imagePattern1,
                datetime: "2016/12/20"
            )
        )
        models.append(
            Sample(
                title: "このサンプルのポイント",
                catchcopy: "AutoLayoutの制約の変更と優先度",
                description: "Xibに切り出したTableViewのセル内に画像を配置していきます。位置に関するAutoLayoutをあらかじめ配置しておき、幅と高さの制約をOutletに切り出します。そして幅と高さの制約については優先度を下げておくのがポイントになります。",
                imageArray: imagePattern2,
                datetime: "2016/12/20"
            )
        )
        models.append(
            Sample(
                title: "画像をタップすると該当の画像を表示",
                catchcopy: "クロージャーと画像のGestureRecognizerを利用",
                description: "画像サムネイルをタップした際は横スクロールの表示画面で該当画像の位置から表示できるようにします。また6枚以上の画像がある際に表示されるボタンを押した場合には、縦の一覧表示をする形にしています。",
                imageArray: imagePattern3,
                datetime: "2016/12/20"
            )
        )
        models.append(
            Sample(
                title: "このサンプルの利用や改変に関して",
                catchcopy: "特に制限はないので自由にカスタマイズなどをしてみて下さい",
                description: "今回の画像のレイアウトサンプルに関しては、各々のレイアウトパターンが試すことができるように画像を30点ほど入れています。ですのでそれぞれのレイアウトを是非とも試してみてはいかがでしょうか。",
                imageArray: imagePattern4,
                datetime: "2016/12/20"
            )
        )
        models.append(
            Sample(
                title: "この中の画像の使用に関して",
                catchcopy: "使っても良いですが画像のクオリティは一旦置いておいてね",
                description: "このサンプルを作成したときは、ちょうどとてもお腹が空いていて「はやく終わらせてご飯が食べたい！」という思いから画像選んだ結果これになりました。",
                imageArray: imagePattern5,
                datetime: "2016/12/20"
            )
        )
        models.append(
            Sample(
                title: "他の機能に関する部分の実装について",
                catchcopy: "今回はタイル状のレイアウト作成が中心なので他の機能は控えめ",
                description: "今回のメイン部分の他にもUICollectionViewを活用したレイアウトに関しても実装を行なっています。Qiitaの記事内でも原理に関しては説明をしていますが、詳しい実装を見たい場合にはコードやプロジェクト内での設定を参照してください。",
                imageArray: imagePattern6,
                datetime: "2016/12/20"
            )
        )
        models.append(
            Sample(
                title: "このサンプルに関して",
                catchcopy: "2016年AdventCalendar「Swiftその2」のネタです",
                description: "今回のサンプルに関してはQiitaのAdventCalendarのためのサンプルになります。誰もが一度試してみたいと思うFacebookやTwitterで使用されているUIの一部分をトレースして再現して見たものになります。",
                imageArray: imagePattern7,
                datetime: "2016/12/20"
            )
        )
        return models
    }

    //画像ファイル名の配列[String]から画像データの配列[UIImage]型のデータを作成する
    fileprivate static func getMockImageList(imageNameList: [String]) -> [UIImage] {

        var imageList: [UIImage] = [UIImage]()
        for (_, imageName) in imageNameList.enumerated() {
            let imageData = UIImage(named: imageName)!
            imageList.append(imageData)
        }
        return imageList
    }
}
