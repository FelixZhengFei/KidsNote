//
//  KDJieQiDetailVC.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/29.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import WebKit

class KDJieQiDetailVC: KDBaseVC {
    
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
    
    fileprivate func updateCell() {
        let type = currentModel.type ?? "1"
        if let path = Bundle.main.path(forResource: "shijie_html_\(type).html", ofType: nil) {
            let urlStr = URL(fileURLWithPath: path)
            let webView = WKWebView(frame: CGRect(x: 0, y: start_Y, width: kScreen_WIDTH, height:kScreen_HEIGHT - start_Y))
            webView.load(URLRequest(url:urlStr))
            webView.scrollView.showsVerticalScrollIndicator = false
            self.view.addSubview(webView)
            webView.alpha = 0.75
            webView.backgroundColor = UIColor.clear
        }
    }
}

