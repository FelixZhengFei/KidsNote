//
//  KDShijHomeCell.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/29.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class KDShijHomeCell: UITableViewCell {
    @IBOutlet weak var jieTitleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    public func updateCellWithModel(model:KDShiJieModel) {
        jieTitleLabel.text = model.title
        timeLabel.text = model.startTime
        iconImageView.image = UIImage(named: "\(model.seasonImage!)")
        let jiejiTyep = Int(model.type!) ?? 0
        if jiejiTyep < 7 {
            jieTitleLabel.textColor = UIColor.ff_HexColor(0x40aa54)
        } else if jiejiTyep >= 7 && jiejiTyep < 13 {
            jieTitleLabel.textColor = UIColor.ff_HexColor(0xde344a)

        } else if jiejiTyep >= 13 && jiejiTyep < 19 {
            jieTitleLabel.textColor = UIColor.ff_HexColor(0xcf6b25)

        } else {
            jieTitleLabel.textColor = UIColor.ff_HexColor(0x1db0d7)
        }
    }
    
    
}
