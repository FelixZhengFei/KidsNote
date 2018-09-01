//
//  KDAppHomeView.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import BYToolModule

class KDAppHomeView: UIView,FFLoadXibProtocol {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wenduLabel: UILabel!
    
    var timeBlcock:(() -> Void)? //24时节
    var shijieBlcock:(() -> Void)? //24时节
    var aboutUsBlcock:(() -> Void)? //24时节

    override func awakeFromNib() {
        
    }
    
    @IBAction func timeButtonClicked(_ sender: Any) {
        timeBlcock!()
    }
    
    @IBAction func detailButtonClicked(_ sender: Any) {
        shijieBlcock!()
    }
    
    @IBAction func aboutUserButtonclicekd(_ sender: Any) {
        aboutUsBlcock!()
    }
    
}
