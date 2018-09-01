//
//  KDTimeShowVC.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/9/1.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class KDTimeShowVC: LUBaseVC {
    fileprivate lazy var timeBaseView = KDJieqiTimeView.ff_LoadXib()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "2018"
        self.view.backgroundColor = UIColor.ff_HexColor(0xF3F4F5)
        timeBaseView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.view.addSubview(timeBaseView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
