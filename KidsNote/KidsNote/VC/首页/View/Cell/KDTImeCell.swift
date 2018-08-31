//
//  KDTImeCell.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/31.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class KDTImeCell: UITableViewCell {

    @IBOutlet weak var jieQiNameLabel: UILabel!
    
    @IBOutlet weak var yangLabel: UILabel!
    
    @IBOutlet weak var yinLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func updateCellWhitModel(_ model:KDShiJieTimeModel) {
        jieQiNameLabel.text = model.title
        yangLabel.text = model.yangTimeString
        yinLabel.text = model.yinTimeString

    }
}
