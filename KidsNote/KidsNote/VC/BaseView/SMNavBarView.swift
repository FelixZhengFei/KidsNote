//
//  SMNavBarView.swift
//  SinaMall
//
//  Created by 王宇浩 on 2018/8/28.
//  Copyright © 2018年 SinaMall. All rights reserved.
//

import UIKit
import SDAutoLayout

class SMNavBarView: UIView {
    /**x小标题*/
    public var titleLabel:UILabel!
    /**大标题*/
    public var bigNavTitleLabel:UILabel!
    /**返回按键*/
    public var backButton:UIButton!
    /**导航文本*/
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
            configNormalHeader()
        }
    }
    /*大标题文本*/
    public var bigNavTitle: String? {
        get {
            return self.bigNavTitleLabel.text
        }
        set {
            self.bigNavTitleLabel.text = newValue
            configLargeHeader()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**设置UI*/
    fileprivate func setupUI() {
        self.frame = CGRect(x: 0, y: 0, width: CGFloat(MSC_WIDTH), height: MNavBar_H);
        self.backgroundColor = WHITCOLOR
        setupTitleLabel()
        setupBackButton()
        setupLargTitleLabel()
    }
    
    /**正常导航*/
    fileprivate func configNormalHeader() {
        self.frame = CGRect(x: 0, y: 0, width: CGFloat(MSC_WIDTH), height: MNavBar_H);
        self.titleLabel.text = title
        self.titleLabel.isHidden = false
        self.bigNavTitleLabel.isHidden = true
    }
    
    /**大导航*/
    fileprivate func configLargeHeader() {
        self.frame = CGRect(x: 0, y: 0, width: CGFloat(MSC_WIDTH), height: MNavBar_H + 44);
        self.titleLabel.isHidden = true
        self.bigNavTitleLabel.isHidden = false
    }
    
    /**title Label*/
    fileprivate func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = SMTEXT_COLOR
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.addSubview(titleLabel)
        _ = titleLabel.sd_layout()
            .widthIs(MSC_WIDTH - 100)?
            .heightIs(44)?
            .leftSpaceToView(self,50)?
            .bottomSpaceToView(self,0)
    }
    
    /**title Label*/
    fileprivate func setupLargTitleLabel() {
        bigNavTitleLabel = UILabel()
        bigNavTitleLabel.textAlignment = .left
        bigNavTitleLabel.textColor = SMTEXT_COLOR
        bigNavTitleLabel.backgroundColor = UIColor.clear
        bigNavTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        self.addSubview(bigNavTitleLabel)
        
        _ = bigNavTitleLabel.sd_layout()
            .widthIs(MSC_WIDTH)?
            .heightIs(44)?
            .leftSpaceToView(self,15)?
            .bottomSpaceToView(self,0)
    }
    
    /**只显示da biao t*/
    public func olnyShowbigNavTitle(_ height:CGFloat) {
        _ = bigNavTitleLabel.sd_layout()
            .widthIs(MSC_WIDTH)?
            .heightIs(height)?
            .leftSpaceToView(self,15)?
            .bottomSpaceToView(self,0)
    }
    
    /**返回按键*/
    fileprivate func setupBackButton() {
        backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: UIControlState(rawValue: 0))
        backButton.setImage(UIImage(named: "back"), for: .highlighted)
        backButton.sizeToFit()
        backButton.backgroundColor = UIColor.clear
        self.addSubview(backButton)
        _ = backButton.sd_layout()
            .widthIs(44)?
            .heightIs(44)?
            .leftSpaceToView(self,0)?
            .topSpaceToView(self,MStatusBar_Height)
        
    }
}
