//
//  SMBaseVC.swift
//  SinaMall
//
//  Created by 王宇浩 on 2018/8/28.
//  Copyright © 2018年 SinaMall. All rights reserved.
//

import UIKit
import MJRefresh

typealias SMCallback = (Any?)->()

/// 基础类
class SMBaseVC: UIViewController {
    var success:SMCallback?
    var cancel:SMCallback?
    
    /**内容的开端*/
    public var start_Y = MNavBar_H
    /**导航栏*/
    public lazy var navigationBarView: SMNavBarView = { ()->SMNavBarView in
        let navview = SMNavBarView(frame: CGRect(x: 0, y: 0, width: MSC_WIDTH, height: 64))
        navview.backgroundColor = WHITCOLOR
        return navview
    }();
    
    /**刷新数据*/
    public func reloadData(){
    }
    
    /**UITableView*/
   public lazy var mTableView: UITableView = { () ->UITableView in
        var tabview: UITableView = UITableView(frame:CGRect(x: 0, y: MNavBar_H, width: MSC_WIDTH, height: MSC_HEIGHT - MNavBar_H), style: .plain)
        tabview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellID")
        tabview.separatorStyle = .none
        return tabview
    }()
    
    final class func create<T: SMBaseVC>(success:SMCallback?,cancel:SMCallback?)-> T{
        let vc = T()
        vc.success = success
        vc.cancel = cancel
        return vc
    }
    
    /**导航栏标题*/
    override open var title: String? {
        get{
            return self.navigationBarView.title
        }
        set {
            start_Y = MNavBar_H
            self.navigationBarView.title = newValue
        }
    }
    
    /**导航栏标题*/
    open var bigNavTitle: String? {
        get{
            return self.navigationBarView.bigNavTitle
        }
        set {
            start_Y = MNavBar_H + MBiG_Title_H
            self.navigationBarView.bigNavTitle = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden=true
        self.setUpAllUI()
        self.view.backgroundColor = SMApp_BG_COLOR
    }
    
    
    deinit {
        SMPrint("\(type(of: self))对象销毁了")
    }
    
    /**是否隐藏导航*/
    public func hideNavBar() {
        navigationBarView.isHidden = true
    }
    
    /**隐藏返回键*/
    public func hideBackButton() {
        self.navigationBarView.backButton.isHidden = true
    }
    
    /**只宣示大标题*/
    public func showOnlyBigNavTitle() {
        self.navigationBarView.backButton.isHidden = true
        start_Y = MNavBar_H + 20
        navigationBarView.frame.size.height = start_Y
        navigationBarView.olnyShowbigNavTitle(start_Y - MStatusBar_Height)
    }
    
    /**返回按键*/
    @objc
    public func backButtonClicked() {
        if let action = self.cancel {
            action(nil)
        } else {
            _ =  self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - 配置基本信息
extension SMBaseVC {
    /**配置基本信息*/
    fileprivate func setUpAllUI() {
        self.view.addSubview(navigationBarView)
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .top
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        navigationBarView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
    }
}
