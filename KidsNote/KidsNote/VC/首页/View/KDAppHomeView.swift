//
//  KDAppHomeView.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import BYToolModule

class KDAppHomeView: UIView,FFLoadXibProtocol {
    @IBOutlet weak var top_Y_coord: NSLayoutConstraint!
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wenduLabel: UILabel!
    
    var timeBlcock:(() -> Void)? //24时节
    var shijieBlcock:(() -> Void)? //24时节
    var aboutUsBlcock:(() -> Void)? //24时节

    override func awakeFromNib() {
        top_Y_coord.constant = kNavBar_H
        configLalebs()
    }
    
    @IBAction func timeButtonClicked(_ sender: Any) {
        timeBlcock!()
    }
    
    @IBAction func detailButtonClicked(_ sender: Any) {
        shijieBlcock!()
    }
    
    @IBAction func aboutUserButtonclicekd(_ sender: Any) {
        aboutUsBlcock!()
    }
    
    fileprivate func configLalebs() {
        var fontSize:CGFloat = 18
        if kScreen_HEIGHT < 540 {
            fontSize = 14
        }
        var start_y:CGFloat = (kScreen_HEIGHT - 380 - kNavBar_H) / 2
        let label1 = UILabel(frame: CGRect(x: kScreen_WIDTH / 2 + 45, y: start_y, width: 30, height: 400))
        label1.font = UIFont.systemFont(ofSize: fontSize)
        label1.backgroundColor = UIColor.clear
        self.addSubview(label1)
        KDGradientHelper.addGradientChromatoAnimation(forLableText: baseView, lable: label1, start: 0)
        label1.verticalText = "春雨惊春清谷天，夏满芒夏暑相连。"
        start_y += 60
        let label2 = UILabel(frame: CGRect(x: kScreen_WIDTH / 2 + 5, y: start_y, width: 30, height: 400))
        label2.font = UIFont.systemFont(ofSize: fontSize)
        label2.backgroundColor = UIColor.clear
        KDGradientHelper.addGradientChromatoAnimation(forLableText: baseView, lable: label2, start: 1)
        label2.verticalText = "秋处露秋寒霜降，冬雪雪冬小大寒。"
        start_y = (kScreen_HEIGHT - 380 - kNavBar_H) / 2

        let label3 = UILabel(frame: CGRect(x: kScreen_WIDTH / 2 - 40, y: start_y, width: 30, height: 400))
        label3.font = UIFont.systemFont(ofSize: fontSize)
        label3.backgroundColor = UIColor.clear
        KDGradientHelper.addGradientChromatoAnimation(forLableText: baseView, lable: label3, start: 2)
        label3.verticalText = "每月两节不变更，最多相差一两天。"
        start_y += 60

        let label4 = UILabel(frame: CGRect(x: kScreen_WIDTH / 2 - 80, y: start_y, width: 30, height: 400))
        label4.font = UIFont.systemFont(ofSize: fontSize)
        label4.backgroundColor = UIColor.clear
        KDGradientHelper.addGradientChromatoAnimation(forLableText: baseView, lable: label4, start: 3)
        label4.verticalText = "上半年逢六廿一，下半年逢八廿三。"
        
    }
    
}
