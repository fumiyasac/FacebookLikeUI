//
//  ThumbnailCell.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/19.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class ThumbnailCell: UITableViewCell {

    //UIパーツの配置
    @IBOutlet weak var thumbnailLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
