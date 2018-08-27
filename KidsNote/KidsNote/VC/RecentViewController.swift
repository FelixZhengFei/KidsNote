//
//  RecentViewController.swift
//  FWSideMenu
//
//  Created by xfg on 2018/4/8.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class RecentViewController: UIViewController {
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置导航栏
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: navTitleFont)]
        self.navigationController?.navigationBar.setBackgroundImage(AppDelegate.resizableImage(imageName: "header_bg_message", edgeInsets: UIEdgeInsetsMake(0, 0, 0, 0)), for: .default)
        
        // 设置状态栏
        UIApplication.shared.statusBarStyle = .lightContent
        
        // 本页面开启支持打开侧滑菜单
        self.menuContainerViewController.sideMenuPanMode = .defaults
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 设置导航栏
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: navTitleFont)]
        self.navigationController?.navigationBar.setBackgroundImage(AppDelegate.getImageWithColor(color: UIColor.white), for: .default)
        
        // 离开本页面时关闭支持打开侧滑菜单
        self.menuContainerViewController.sideMenuPanMode = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
//        self.navigationItem.title = "消息"
//        self.view.frame.size.height = UIScreen.main.bounds.height - kStatusAndNavBarHeight - MTabBar_Height
        
//        for index in 0...self.imageArray.count {
//            self.timeArray.append(self.obtainRandomTime(index: index))
//        }
//
        let buttonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "header"), style: .plain, target: self, action: #selector(leftBtnAction))
        buttonItem.imageInsets = UIEdgeInsetsMake(0, -6, 0, 0)
        self.navigationItem.leftBarButtonItem = buttonItem
        
        let buttonItem2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "mqz_nav_add"), style: .plain, target: self, action: #selector(rightBtnAction))
        buttonItem2.imageInsets = UIEdgeInsetsMake(0, 0, 0, -6)
        self.navigationItem.rightBarButtonItem = buttonItem2

    }
    
    @objc func leftBtnAction() {
        self.menuContainerViewController.toggleLeftSideMenu(completeBolck: nil)
    }
    
    @objc func rightBtnAction() {
        self.menuContainerViewController.toggleRightSideMenu(completeBolck: nil)
    }
    
    func obtainRandomTime(index: Int) -> String {
        return "\(arc4random()%2 == 0 ? "上午" : "下午")" + "\(arc4random()%12):\(arc4random()%5)\(arc4random()%9)"
    }
}

