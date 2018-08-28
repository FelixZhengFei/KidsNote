//
//  KDDuShuVC.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class KDDuShuVC: KNBaseVC {

    var imageArray: [String] = ["y","数学","英文","自然科学","美术","音乐"]
    
    
    lazy var tableView: UITableView = {
        
        let tableview = UITableView(frame: self.view.bounds)
        tableview.separatorStyle = .none
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "读书列表"
        configViews()
    }

}

extension KDDuShuVC:UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func configViews() {
        self.view.addSubview(self.tableView)
        self.tableView.register(UINib(nibName: "KDDuSHuCell", bundle: nil), forCellReuseIdentifier: "cellId")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! KDDuSHuCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(KDDuShuDetailVC(), animated: true)
    }
}
