//
//  KDSyllabusHomeVC.swift
//  FWSideMenu
//
//  Created by xfg on 2018/4/10.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit


/// 课程表
class KDSyllabusHomeVC: KNBaseVC {
    
    var imageArray: [String] = ["y","数学","英文","自然科学","美术","音乐"]

    
    lazy var tableView: UITableView = {
        
        let tableview = UITableView(frame: self.view.bounds)
        tableview.separatorStyle = .none
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "课程表"
        configViews()
    }
}

extension KDSyllabusHomeVC:UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func configViews() {
        self.view.addSubview(self.tableView)
        self.tableView.register(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! RecentTableViewCell
//        cell.headerImgView.image = UIImage(named: self.imageArray[indexPath.row])
//        cell.nameLabel.text = self.titleArray[indexPath.row]
//        cell.decLabel.text = self.decArray[indexPath.row]
//        cell.timeLabel.text = self.timeArray[indexPath.row]
//        if cell.decLabel.text!.count > 15 {
//            cell.tipLabel.isHidden = false
//            cell.tipLabel.text = "\(cell.decLabel.text!.count % 10)"
//        } else {
//            cell.tipLabel.isHidden = true
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("您当前点击了第 \(indexPath.row + 1) 行")
        self.navigationController?.pushViewController(SubViewController(), animated: true)
    }
}

