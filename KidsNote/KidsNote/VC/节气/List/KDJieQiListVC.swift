//
//  KDJieQiListVC.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/29.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit

class KDJieQiListVC: KNBaseVC {
    
   fileprivate var dataSourceArray = [KDShiJieModel]()
    
    
   fileprivate lazy var tableView: UITableView = {
        let tableview = UITableView(frame: self.view.bounds)
        tableview.separatorStyle = .none
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "24时节"
        configViews()
        getData()
    }
}

extension KDJieQiListVC:UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func configViews() {
        self.tableView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT - MNavBar_H)
        self.view.addSubview(self.tableView)
        self.tableView.register(UINib(nibName: "KDShijHomeCell", bundle: nil), forCellReuseIdentifier: "cellId")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    fileprivate func getData() {
        if let path = Bundle.main.path(forResource: "jieqiinfo.plist", ofType: nil),
            let data = NSArray(contentsOfFile: path),
            let itemDatas = try? KDShiJieModel.mapArrayFromJson(data as AnyObject, KDShiJieModel.self) {
            dataSourceArray = itemDatas
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! KDShijHomeCell
        cell.updateCellWithModel(model: dataSourceArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(KDDuShuDetailVC(), animated: true)
    }
}

