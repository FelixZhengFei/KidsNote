//
//  KDJieqiTimeView.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/31.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import BYToolModule

class KDJieqiTimeView: UIView,FFLoadXibProtocol {
    fileprivate var dataSourceArray = [KDShiJieTimeModel]()
    
    @IBOutlet weak var top_Y_coord: NSLayoutConstraint!
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func awakeFromNib() {
        top_Y_coord.constant = 10
        configViews()
    }
    
    public func updateDataWithIndex(_ selectIndex:Int) {
        if selectIndex  == 0 {
            if let path = Bundle.main.path(forResource: "jieqiTime2018.plist", ofType: nil),
                let data = NSArray(contentsOfFile: path),
                let itemDatas = try? KDShiJieTimeModel.mapArrayFromJson(data as AnyObject, KDShiJieTimeModel.self) {
                dataSourceArray = itemDatas
                self.tableview.reloadData()
            }
        } else if selectIndex == 1{
            if let path = Bundle.main.path(forResource: "jieqiTime2019.plist", ofType: nil),
                let data = NSArray(contentsOfFile: path),
                let itemDatas = try? KDShiJieTimeModel.mapArrayFromJson(data as AnyObject, KDShiJieTimeModel.self) {
                dataSourceArray = itemDatas
                self.tableview.reloadData()
            }
        } else if selectIndex == 2{
            if let path = Bundle.main.path(forResource: "jieqiTime2020.plist", ofType: nil),
                let data = NSArray(contentsOfFile: path),
                let itemDatas = try? KDShiJieTimeModel.mapArrayFromJson(data as AnyObject, KDShiJieTimeModel.self) {
                dataSourceArray = itemDatas
                self.tableview.reloadData()
            }
        }
    }
}


extension KDJieqiTimeView:UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func configViews() {
        self.tableview.register(UINib(nibName: "KDTImeCell", bundle: nil), forCellReuseIdentifier: "KDTImeCell")
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KDTImeCell", for: indexPath) as! KDTImeCell
        cell.updateCellWhitModel(dataSourceArray[indexPath.row])
        return cell
    }
    
}
