//
//  KDContactHomeVC.swift
//  FWSideMenu
//
//  Created by xfg on 2018/4/10.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class KDContactHomeVC: KNBaseVC {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "联系人"
        let buttonItem2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "mqz_nav_add"), style: .plain, target: self, action: #selector(rightBtnAction))
        buttonItem2.imageInsets = UIEdgeInsetsMake(0, 0, 0, -6)
        self.navigationItem.rightBarButtonItem = buttonItem2
    }
    
    @objc func rightBtnAction() {
        FFPrint("添加联系人")
    }
}
