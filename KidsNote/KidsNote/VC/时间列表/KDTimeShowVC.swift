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
    fileprivate lazy var headerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.ff_HexColor(0xF3F4F5)
        timeBaseView.frame = CGRect(x: 0, y: MNavBar_H, width: MSC_WIDTH, height: MSC_HEIGHT - MNavBar_H)
        self.view.addSubview(timeBaseView)
        timeBaseView.updateDataWithIndex(0)
        configHeaderView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    fileprivate func configHeaderView() {
        let headerView = UIView(frame: CGRect(x: 50, y: MStatusBar_Height, width: MSC_WIDTH - 100, height: 44))
        self.navigationHeaderView.addSubview(headerView)
        headerView.backgroundColor = UIColor.clear
        
        headerButton = UIButton(type: .custom)
        headerButton.frame =  CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height)
        headerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        headerButton.setTitleColor(UIColor.ff_HexColor(0x333333), for: .normal)
        headerView.addSubview(headerButton)
        headerButton.setTitle("2018年", for: .normal)
        headerButton.addTarget(self, action: #selector(headerButtonClicked(sender:)), for: .touchUpInside)
        let image = UIImageView(image: #imageLiteral(resourceName: "jiantou_xia"))
        image.frame = CGRect(x: headerView.frame.width / 2 + 40, y: 12, width: 20, height: 20)
        headerView.addSubview(image)
    }
    
    @objc fileprivate func headerButtonClicked(sender:UIButton) {
        weak var weakSelf = self
        let action1 = YCMenuAction(title: "2018年", image: nil) { (action) in
            weakSelf?.headerButton.setTitle("2018年", for: .normal)
            weakSelf?.timeBaseView.updateDataWithIndex(0)

        }
        let action2 = YCMenuAction(title: "2019年", image: nil) { (action) in
            weakSelf?.headerButton.setTitle("2019年", for: .normal)
            weakSelf?.timeBaseView.updateDataWithIndex(1)

        }
        let action3 = YCMenuAction(title: "2020年", image: nil) { (action) in
            weakSelf?.headerButton.setTitle("2020年", for: .normal)
            weakSelf?.timeBaseView.updateDataWithIndex(2)

        }
        let showView = YCMenuView.menu(with: [action1!,action2!,action3!], width: 100, relyonView: sender)
        showView?.show()
    }
    
}
