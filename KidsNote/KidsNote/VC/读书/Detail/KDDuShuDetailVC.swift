//
//  KDDuShuDetailVC.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import SDWebImage

class KDDuShuDetailVC: KNBaseVC {

    @IBOutlet weak var siImageView: UIImageView!
    @IBOutlet weak var luyinView: UIView!
    var hasImage:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "静夜思"
        configButtomview()
        siImageView.sd_setImage(with: URL(string: "http://i65.tinypic.com/wgzrww.jpg"), placeholderImage: UIImage(named: "header"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showTheVidioToWebView(_ sender: Any) {
        let vc = SMWebVC()
        vc.urlString  = "https://m.qbaobei.com/v/video_569.html"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func configButtomview() {
        let chiledVC = PIVoiceRecordViewController()
        chiledVC.view.frame = CGRect(x: 0, y: 20, width: MSC_WIDTH, height: 100)
        luyinView.addSubview(chiledVC.view)
        self.addChildViewController(chiledVC)
    }
    
}


