//
//  SMNavgationVC.swift
//  SinaMall
//
//  Created by 王宇浩 on 2018/8/28.
//  Copyright © 2018年 SinaMall. All rights reserved.
//

import UIKit

/// 自定义导航
class SMNavgationVC: UINavigationController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        self.interactivePopGestureRecognizer?.delegate = self;
    }
    
    ///重载pushViewController
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.childViewControllers.count==1) {
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    ///重载popViewController
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        if self.childViewControllers.count == 2 {
            self.childViewControllers.last?.hidesBottomBarWhenPushed = true
        }
        return vc
    }
    
    ///重载gestureRecognizerShouldBegin
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count > 1;
    }
}
