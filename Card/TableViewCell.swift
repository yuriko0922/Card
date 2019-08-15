//
//  TableViewCell.swift
//  Card
//
//  Created by 津國　由莉子 on 2019/08/15.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    // 画像のやつ紐ずけ
    @IBOutlet weak var imageView2: UIImageView!
    // 名前ラベル紐ずけ
    @IBOutlet weak var nameLabel: UILabel!
    // 仕事ラベル紐ずけ
    @IBOutlet weak var jobLabel: UILabel!
    // 出身地ラベル紐ずけ
    @IBOutlet weak var fromLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
