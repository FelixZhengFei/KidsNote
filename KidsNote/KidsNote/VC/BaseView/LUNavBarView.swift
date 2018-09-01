//
//  LUNavBarView.swift
//  LineUp
//
//  Created by 郑强飞 on 2018/06/28.
//  Copyright © 2018年 LineUp. All rights reserved.
//

import UIKit
class LUNavBarView: UIView {
    public var titleLabel:UILabel!
    
    public var leftButton:UIButton!
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        self.frame = CGRect(x: 0, y: 0, width: CGFloat(MSC_WIDTH), height: MNavBar_H);
        self.backgroundColor = UIColor.white
        setupTitleLabel()
        setupLeftButton()
    }
    
    /**title Label*/
    fileprivate func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.ff_HexColor(0x333333)
        titleLabel.backgroundColor = UIColor.clear
        if #available(iOS 8.2, *) {
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 17)
        }
        self.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 50, y: MStatusBar_Height, width: MSC_WIDTH - 100, height: 44)

    }
    
    /**返回按键*/
    fileprivate func setupLeftButton() {
        leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "com_arrow_vc_back"), for: UIControlState(rawValue: 0))
        leftButton.setImage(UIImage(named: "com_arrow_vc_back"), for: .highlighted)
        leftButton.sizeToFit()
        leftButton.backgroundColor = UIColor.clear
        self.addSubview(leftButton)
        leftButton.frame = CGRect(x: 0, y: MStatusBar_Height, width: 44, height: 44)
    }
}
