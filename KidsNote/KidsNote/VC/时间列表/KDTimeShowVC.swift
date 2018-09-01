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
        self.view.backgroundColor = UIColor.white
        timeBaseView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.view.addSubview(timeBaseView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
