//
//  KDAppHomeVC.swift
//  FWSideMenu
//
//  Created by xfg on 2018/4/8.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class KDAppHomeVC: KNBaseVC {
    fileprivate lazy var homeView = KDAppHomeView.ff_LoadXib()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.menuContainerViewController.sideMenuPanMode = .defaults
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "首页"
        configViews()
    }
    
    fileprivate func configViews() {
        homeView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.view.addSubview(homeView)
        weak var weakSelf = self
        homeView.dusShuBlcock = {
            weakSelf?.dushuButtonCcliekd()
        }
        
        let buttonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(leftBtnAction))
        buttonItem.imageInsets = UIEdgeInsetsMake(0, -6, 0, 0)
        self.navigationItem.leftBarButtonItem = buttonItem
        
        let buttonItem2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "mqz_nav_add"), style: .plain, target: self, action: #selector(rightBtnAction))
        buttonItem2.imageInsets = UIEdgeInsetsMake(0, 0, 0, -6)
        self.navigationItem.rightBarButtonItem = buttonItem2
    }
    
    @objc func rightBtnAction() {
        FFPrint("添加联系人")
    }
    
    @objc func leftBtnAction() {
        self.menuContainerViewController.toggleLeftSideMenu(completeBolck: nil)
    }

    fileprivate func dushuButtonCcliekd() {
        self.navigationController?.pushViewController(KDDuShuVC(), animated: true)
    }
    
}

