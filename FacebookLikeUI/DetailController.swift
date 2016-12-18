//
//  DetailController.swift
//  FacebookLikeUI
//
//  Created by 酒井文也 on 2016/12/18.
//  Copyright © 2016年 just1factory. All rights reserved.
//

import UIKit

class DetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var detailTableView: UITableView!
    
    var hv: CustomTableViewHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        
        hv = CustomTableViewHeader.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 240))
        
        detailTableView.tableHeaderView = hv
        
        
        let nibContentsTableView: UINib = UINib(nibName: "MainContentsCell", bundle: nil)
        
        detailTableView.register(nibContentsTableView, forCellReuseIdentifier: "MainContentsCell")
    }

    //テーブルの要素数を設定する ※必須
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //テーブルの行数を設定する ※必須
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    //表示するセルの中身を設定する ※必須
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainContentsCell") as? MainContentsCell
        
        cell!.accessoryType = UITableViewCellAccessoryType.none
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        hv.scrollViewDidScroll(scrollView)
    }
    
}
