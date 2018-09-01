//
//  KNBaseVC.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class KNBaseVC: UIViewController {

    /**导航栏标题*/
    override open var title: String? {
        get{
            return ""
        }
        set {
            self.navigationItem.title = newValue
        }
    }
    public var start_Y:CGFloat = MNavBar_H
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置导航栏
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: navTitleFont)]
//        self.navigationController?.navigationBar.setBackgroundImage(AppDelegate.getImageWithColor(color: UIColor.white), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

}
