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
    fileprivate lazy var timeBaseView = KDJieqiTimeView.ff_LoadXib()
    fileprivate lazy var  weatherView = WHWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "24节气"
        configViews()
        getCityWeathcer()
        getCurrentTime()
    }
    
    fileprivate func configViews() {
        homeView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
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
        timeBaseView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.view.addSubview(timeBaseView)
    }
    
    /**关于*/
    fileprivate func showAboutUsview() {
        self.navigationController?.pushViewController(KDAboutUsVC(), animated: true)
    }
    
    /**当前时间*/
    fileprivate func getCurrentTime() {
        let newInfo = DDDateCal.currentDateInfo()
        let chinsesDateInfo = DDDateCal.transfromDateTomChinseDate(inputDate: (newInfo.year,newInfo.month,1));
        
        homeView.timeLabel.text = "\(newInfo.year)年\(newInfo.month)月  \(chinsesDateInfo?.year ?? "未知")年\(chinsesDateInfo?.month ?? "未知")";
    }
    
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
            homeView.wenduLabel.text = "\(text_day)  温度：\(low)°C ~ \(high)°C"
            configWeatherView(code_day)
        }
    }
    
    /**配置天气*/
    fileprivate func configWeatherView(_ codeDayString:String) {
        let codeDay = Int32(codeDayString) ?? 0
        self.weatherView.frame = CGRect(x: 0, y: 0, width: MSC_WIDTH, height: MSC_HEIGHT)
        self.weatherView.showWeatherAnimation(withType: codeDay)
        self.view.insertSubview(self.weatherView, at: 0)
        
    }
}
