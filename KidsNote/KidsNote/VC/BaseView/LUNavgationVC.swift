//
//  LUNavgationVC.swift
//  LineUp
//
//  Created by 郑强飞 on 2018/06/28.
//  Copyright © 2018年 LineUp. All rights reserved.
//

import UIKit
/** 基类导航控制器
 */
class LUNavgationVC: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        self.interactivePopGestureRecognizer?.delegate = self;
        self.view.backgroundColor = UIColor.white

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.childViewControllers.count==1) {
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
       let vc = super.popViewController(animated: animated)
        if self.childViewControllers.count == 2 {
            self.childViewControllers.last?.hidesBottomBarWhenPushed = true
        }
        return vc
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count > 1;
    }
}
