//
//  LikedListTableViewController.swift
//  Card
//
//  Created by 原田悠嗣 on 2019/08/10.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class LikedListTableViewController: UITableViewController {
    
    // いいねされた名前、仕事、出身地
    var likedName: [String] = []
    var jobLike: [String] = []
    var fromeLiked: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Table view data source
    
    // 必須:セルの数を返すメソッド
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // いいねされたユーザーの数
        return likedName.count
    }
    // セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // 必須:セルの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        // いいねされた名前、職業、出身地、画像表示
        cell.nameLabel.text = likedName[indexPath.row]
        cell.jobLabel.text = jobLike[indexPath.row]
        cell.fromLabel.text = fromeLiked[indexPath.row]
        cell.imageView2.image = UIImage(named: likedName[indexPath.row])
        return cell
    }
    
}
