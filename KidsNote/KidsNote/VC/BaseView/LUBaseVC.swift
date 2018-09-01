//
//  LUBaseVC.swift
//  LineUp
//
//  Created by 郑强飞 on 2018/06/28.
//  Copyright © 2018年 LineUp. All rights reserved.
//

import UIKit

class LUBaseVC: UIViewController {

    public var start_Y = MNavBar_H

    /**导航栏*/
    lazy var navigationHeaderView: LUNavBarView = { ()->LUNavBarView in
        let navview = LUNavBarView(frame: CGRect(x: 0, y: 0, width: MSC_WIDTH, height: 64))
        return navview
    }();

    /**导航栏标题*/
    override open var title: String? {
        get{
            return self.navigationHeaderView.title
        }
        set {
            start_Y = MNavBar_H
            self.navigationHeaderView.title = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden=true
        self.setUpAllUI()
        self.view.backgroundColor = UIColor.white
    }
    
    /**是否隐藏导航*/
    public func hideNavgationBar() {
        navigationHeaderView.isHidden = true
    }
    
    /**隐藏返回键*/
    public func hideBackButton() {
        self.navigationHeaderView.leftButton.isHidden = true
    }
    
    /**返回按键*/
    @objc
    public func leftButtonClicked() {
        _ =  self.navigationController?.popViewController(animated: true)
    }
}

extension LUBaseVC  {
    /**配置基本信息*/
    fileprivate func setUpAllUI() {
        self.view.addSubview(navigationHeaderView)
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .top
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        navigationHeaderView.leftButton.addTarget(self, action: #selector(leftButtonClicked), for: .touchUpInside)
    }
}
