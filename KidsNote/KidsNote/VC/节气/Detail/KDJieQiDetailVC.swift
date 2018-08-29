//
//  KDJieQiDetailVC.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/29.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class KDJieQiDetailVC: KNBaseVC {

    @IBOutlet weak var deicbleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    public var currentModel:KDShiJieModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentModel.title
        bgImageView.image = UIImage(named: "\(currentModel.imageName!)")
        updateCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension KDJieQiDetailVC {

    fileprivate func updateCell() {
        let jiJieType = currentModel.type ?? "1"
        var decibelString = ""
        if jiJieType == "1" {
decibelString = currentModel.detailText ?? ""
//            deicbleLabel.text = decibelString
        

        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 10
        //样式属性集合
        let attributes = [kCTFontAttributeName:UIFont.systemFont(ofSize:17),kCTParagraphStyleAttributeName: paraph]
        deicbleLabel.attributedText = NSAttributedString(string: decibelString, attributes: attributes as [NSAttributedStringKey : Any])
        
        
        
        }
        
    }
}
