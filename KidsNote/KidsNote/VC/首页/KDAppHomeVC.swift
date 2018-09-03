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

class KDAppHomeVC: KDBaseVC {
    fileprivate lazy var homeView = KDAppHomeView.ff_LoadXib()
    fileprivate lazy var  weatherView = KDWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "24节气"
        self.navigationHeaderView.backgroundColor = UIColor.clear
        self.hideBackButton()
        configViews()
        getCurrentTime()
        weak var weakSelf = self
        DKLocationManager.shared.start {
            weakSelf?.getCityWeathcer()
        }
    }
    
    fileprivate func configViews() {
        homeView.frame = CGRect(x: 0, y: 0, width: kScreen_WIDTH, height: kScreen_HEIGHT)
        self.view.backgroundColor = self.view.getBlueGradientColor()
        self.view.addSubview(homeView)
        weak var weakSelf = self
        homeView.shijieBlcock = {
            weakSelf?.shijieButtonClecked()
        }
        homeView.timeBlcock = {
            weakSelf?.showTimeView()
        }
        homeView.aboutUsBlcock = {
            weakSelf?.showAboutUsview()
        }
    }
}

extension KDAppHomeVC {
    
    /**24时节*/
    fileprivate func shijieButtonClecked() {
        self.navigationController?.pushViewController(KDQijieHomeVC(), animated: true)
    }
    
    /**时间列表*/
    fileprivate func showTimeView() {
        self.navigationController?.pushViewController(KDTimeShowVC(), animated: true)
    }
    
    /**关于*/
    fileprivate func showAboutUsview() {
        self.navigationController?.pushViewController(KDAboutUsVC(), animated: true)
    }
    
    /**当前时间*/
    fileprivate func getCurrentTime() {
        let newInfo = KDDatePlugin.currentDateInfo()
        let chinsesDateInfo = KDDatePlugin.transfromDateTomChinseDate(inputDate: (newInfo.year,newInfo.month,1));
        
        homeView.timeLabel.text = "\(newInfo.year)年\(newInfo.month)月\(newInfo.day)日 | \(chinsesDateInfo?.year ?? "未知")年\(chinsesDateInfo?.month ?? "未知")";
    }
    
    /**获取天气*/
    fileprivate func getCityWeathcer() {
        weak var weakSelf = self
        let citySting = DKMemoryManager.userCity ?? "hangzhou"
        
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
            homeView.cityLabel.text =  DKMemoryManager.userCity
            homeView.wenduLabel.text = "\(text_day)  温度：\(low)°C ~ \(high)°C"
            configWeatherView(code_day)
        }
    }
    
    /**配置天气*/
    fileprivate func configWeatherView(_ codeDayString:String) {
        let codeDay = Int32(codeDayString) ?? 0
        self.weatherView.frame = CGRect(x: 0, y: 0, width: kScreen_WIDTH, height: kScreen_HEIGHT)
        self.weatherView.showWeatherAnimation(withType: codeDay)
        self.view.insertSubview(self.weatherView, at: 0)
        
        if (codeDay >= 10 && codeDay < 20) {
            self.navigationHeaderView.titleLabel.textColor = UIColor.white
        }
    }
}
