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
        self.title = "首页"
        self.navigationController?.navigationBar.isHidden = true
        configViews()
        getCityWeathcer()
    }
    
    fileprivate func configViews() {
        homeView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.view.addSubview(homeView)
        weak var weakSelf = self
        homeView.dusShuBlcock = {
            weakSelf?.dushuButtonCcliekd()
        }
        homeView.shijieBlcock = {
            weakSelf?.shijieButtonClecked()
        }
        let buttonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(leftBtnAction))
        buttonItem.imageInsets = UIEdgeInsetsMake(0, -6, 0, 0)
        self.navigationItem.leftBarButtonItem = buttonItem
        
        let buttonItem2: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "mqz_nav_add"), style: .plain, target: self, action: #selector(rightBtnAction))
        buttonItem2.imageInsets = UIEdgeInsetsMake(0, 0, 0, -6)
        self.navigationItem.rightBarButtonItem = buttonItem2
    }
    
    @objc func rightBtnAction() {
        FFPrint("添加联系人")
    }
    
    @objc func leftBtnAction() {
        self.menuContainerViewController.toggleLeftSideMenu(completeBolck: nil)
    }
    
    /**古诗列表*/
    fileprivate func dushuButtonCcliekd() {
        self.navigationController?.pushViewController(KDDuShuVC(), animated: true)
    }
    
    /**24时节*/
    fileprivate func shijieButtonClecked() {
        self.navigationController?.pushViewController(KDJieQiListVC(), animated: true)
        
        
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
            let date = dic["date"] as? String,
            let high = dic["high"] as? String,
            let low = dic["low"] as? String{
            FFPrint("code_day====\(code_day)")
            FFPrint("\(text_day)")
            FFPrint("date===\(date)")
            FFPrint("\(high)")
            FFPrint("\(low)")
            homeView.cityLabel.text =  FFMemoryManager.userCity
            homeView.timeLabel.text =  date
            homeView.wenduLabel.text =  "温度：\(low)°C ~ \(high)°C"

            configWeatherView(code_day)
        }
    }
    
    /**配置天气*/
    fileprivate func configWeatherView(_ codeDayString:String) {
        let codeDay = Int(codeDayString) ?? 0
        var bgImageName = "sun_bg"
        var weathType:WHWeatherType = .sun
        
//        if codeDay >= 0 && codeDay < 4 { //晴天
//            bgImageName = "sun_0"
//            weathType = .sun
//
//        } else if codeDay >= 4 && codeDay < 10  { //多云
//            bgImageName = "sun_1"
//            weathType = .clound
//
//        } else if codeDay >= 10 && codeDay < 20  { //雨
//            bgImageName = "rain_5"
//            weathType = .rain
//
//        } else if codeDay >= 20 && codeDay < 26  { //雪
//            bgImageName = "rain_5"
//            weathType = .snow
//
//        } else if codeDay >= 26 && codeDay < 30  { //沙尘暴
//
//        } else if codeDay >= 30 && codeDay < 32  { //雾霾
//            bgImageName = "rain_5"
//            weathType = .rainLighting
//
//        } else if codeDay >= 32 && codeDay < 37  { //风
//
//        } else {  //未知
//
//        }
        self.weatherView.weatherBackImageView.image = UIImage(named: bgImageName)
        self.weatherView.weatherBackImageView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.view.insertSubview(self.weatherView.weatherBackImageView, at: 0)
        self.weatherView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.weatherView.showWeatherAnimation(with:weathType)
        self.view.insertSubview(self.weatherView, at: 1)

    }
}
