//
//  Sample.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/19.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

//ダミーデータを仕込むためのクラス
class Sample {
    
    //メインデータの変数
    var title: String
    var catchcopy: String
    var description: String
    var imageArray: [UIImage]
    var datetime: String
    
    //初期化
    init(title: String, catchcopy: String, description: String, imageArray: [UIImage], datetime: String) {
        self.title = title
        self.catchcopy = catchcopy
        self.description = description
        self.imageArray = imageArray
        self.datetime = datetime
    }
}
