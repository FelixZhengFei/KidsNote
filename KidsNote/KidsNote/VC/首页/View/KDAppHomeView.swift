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
    
    var dusShuBlcock:(() -> Void)?
    var shijieBlcock:(() -> Void)? //24时节

    override func awakeFromNib() {
        
    }
    
    @IBAction func duShuButtonClicked(_ sender: Any) {
        dusShuBlcock!()
    }
    @IBAction func shijieButtonClicked(_ sender: Any) {
        shijieBlcock!()

    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
