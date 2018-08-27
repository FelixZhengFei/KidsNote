//
//  SMTabBarVC.swift
//  SinaMall
//
//  Created by 王宇浩 on 2018/08/28.
//  Copyright © 2018年 SinaMall. All rights reserved.
//

import UIKit

let TabBarSourcePath = "SMTabBar.plist"

/**
 * TabBarDataModel对象
 */
class TabBarDataModel: SMBaseMappable {
    var title = ""
    var VC = ""
    var norImage = ""
    var selectImage = ""
}

/**
 * SMTabBarVC
 */
class SMTabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()//
        configChildVC()
    }
}

//配置viewControllers
extension SMTabBarVC {
    
    fileprivate func configTabbar() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        self.tabBar.tintColor = UIColor.ff_HexColor(0xFF6262)
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = SMTEXT_COLOR
        }
        UITabBar.appearance().backgroundColor = UIColor.white
        self.tabBar.layer.shouldRasterize = true
        self.tabBar.layer.shadowColor = UIColor.ff_HexColor(0xE2E2E2).cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 4, height: 1)
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.shadowRadius = 5
    }
    
    //配置
    private func configChildVC() {
        if let path = Bundle.main.path(forResource: TabBarSourcePath, ofType: nil),
            let data = NSArray(contentsOfFile: path),
            let itemDatas = try? TabBarDataModel.mapArrayFromJson(data as AnyObject, TabBarDataModel.self){
            var subVCArr  = [UIViewController]()
            for item in itemDatas {
                subVCArr.append(SMTabBarVC.createItmeWithDic(model: item))
            }
            viewControllers = subVCArr
        }
    }
    
    /// 创建对象
    class func createItmeWithDic(model: TabBarDataModel) -> SMNavgationVC {
        let vcClass =  NSClassFromString(model.VC) as? UIViewController.Type
        guard let vc = vcClass?.init() else { return SMNavgationVC()}
        vc.title = model.title
        //导航
        let navBar = SMNavgationVC(rootViewController: vc)
        navBar.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        navBar.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);

        navBar.tabBarItem.image = UIImage(named: model.norImage)?.withRenderingMode(.alwaysOriginal)
        navBar.tabBarItem.selectedImage =  UIImage(named: model.selectImage)?.withRenderingMode(.alwaysOriginal)
        return navBar
    }
}


