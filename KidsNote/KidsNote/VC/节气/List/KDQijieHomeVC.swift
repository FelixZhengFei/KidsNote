//
//  KDQijieHomeVC.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/31.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class KDQijieHomeVC: KNBaseVC {
    fileprivate var dataSourceArray = [KDShiJieModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "24节气"
        getData()
    }

    fileprivate func getData() {
        if let path = Bundle.main.path(forResource: "jieqiinfo.plist", ofType: nil),
            let data = NSArray(contentsOfFile: path),
            let itemDatas = try? KDShiJieModel.mapArrayFromJson(data as AnyObject, KDShiJieModel.self) {
            dataSourceArray = itemDatas
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonCLicked(_ sender: UIButton) {
        FFPrint("点击===\(sender.tag)")

        if sender.tag < dataSourceArray.count {
            let vc = KDJieQiDetailVC()
            vc.currentModel = dataSourceArray[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
