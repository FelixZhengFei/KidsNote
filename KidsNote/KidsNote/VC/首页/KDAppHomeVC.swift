//
//  KDAppHomeVC.swift
//  FWSideMenu
//
//  Created by xfg on 2018/4/8.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class KDAppHomeVC: KNBaseVC {
    fileprivate lazy var homeView = KDAppHomeView.ff_LoadXib()
    fileprivate lazy var  weatherView = WHWeatherView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.menuContainerViewController.sideMenuPanMode = .defaults
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "24节气"
        configViews()
        getCityWeathcer()
        let newInfo = DDDateCal.currentDateInfo()
        let chinsesDateInfo = DDDateCal.transfromDateTomChinseDate(inputDate: (newInfo.year,newInfo.month,1));

        homeView.timeLabel.text = "\(newInfo.year)年\(newInfo.month)月  \(chinsesDateInfo?.year ?? "未知")年\(chinsesDateInfo?.month ?? "未知")";
    }
    
    fileprivate func configViews() {
        homeView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.view.addSubview(homeView)
        weak var weakSelf = self
        homeView.shijieBlcock = {
            weakSelf?.shijieButtonClecked()
        }
        let buttonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(leftBtnAction))
        buttonItem.imageInsets = UIEdgeInsetsMake(0, -6, 0, 0)
        self.navigationItem.leftBarButtonItem = buttonItem
        

    }
    
    @objc func leftBtnAction() {
        self.menuContainerViewController.toggleLeftSideMenu(completeBolck: nil)
    }

    /**24时节*/
    fileprivate func shijieButtonClecked() {
        self.navigationController?.pushViewController(KDQijieHomeVC(), animated: true)
    }
}

extension KDAppHomeVC {
    
    /**获取天气*/
    fileprivate func getCityWeathcer() {
        weak var weakSelf = self
        let citySting = FFMemoryManager.userCity ?? "hangzhou"
        
        var urlString = "https://api.thinkpage.cn/v3/weather/daily.json?key=osoydf7ademn8ybv&location=\(citySting)&language=zh-Hans&start=0&days=1"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        Alamofire.request(urlString).responseJSON { response in
            if let JSON = response.result.value as? [String : Any],
                let reslut = JSON["results"] as? [Any],
                let firstDic = reslut[0] as? [String:Any],
                let daily = firstDic["daily"] as? [[String:Any]] {
                weakSelf?.jsonWeatherDataOneDay(daily[0])
            }
        }
    }
    
    /**解析天气*/
    fileprivate func jsonWeatherDataOneDay(_ dic:[String:Any]) {
        if let code_day = dic["code_day"] as? String,
            let text_day = dic["text_day"] as? String,
            let high = dic["high"] as? String,
            let low = dic["low"] as? String{
            homeView.cityLabel.text =  FFMemoryManager.userCity
//            homeView.timeLabel.text =  date
            homeView.wenduLabel.text = "\(text_day)  温度：\(low)°C ~ \(high)°C"
            configWeatherView(code_day)
        }
    }
    
    /**配置天气*/
    fileprivate func configWeatherView(_ codeDayString:String) {
        let codeDay = Int32(codeDayString) ?? 0
        self.weatherView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.weatherView.showWeatherAnimation(withType: 1)
        self.view.insertSubview(self.weatherView, at: 0)

    }
}
