//
//  LocationManager.swift
//  GuanXinBussinessApp
//
//  Created by 郑强飞 on 16/11/28.
//  Copyright © 2016年 郑强飞. All rights reserved.
//


import UIKit
import CoreLocation

/**
 //用户尚未做出选择
 kCLAuthorizationStatusNotDetermined = 0,
 
 // 未授权，且用户无法更新，如家长控制情况下
 kCLAuthorizationStatusRestricted,
 
 // 用户拒绝App使用
 kCLAuthorizationStatusDenied,
 
 // 总是使用
 kCLAuthorizationStatusAuthorizedAlways NS_ENUM_AVAILABLE(NA, 8_0),
 
 // 按需使用
 kCLAuthorizationStatusAuthorizedWhenInUse NS_ENUM_AVAILABLE(NA, 8_0),
 
 // 已授权（iOS7以后已经废弃）
 kCLAuthorizationStatusAuthorized
 */

public class FFLocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager: CLLocationManager = CLLocationManager()
    private var placemark: ((CLPlacemark) -> Void)? = nil
    var currLocation:CLLocation = CLLocation()
    
    // MARK: - 单例
    public static let shared = FFLocationManager()
    
    private override init() {
        
    }
    
    // MARK: - 回调权限
    typealias CallbackAuthorizationStatusValue = (_ authStatus: CLAuthorizationStatus) -> Void
    private var  authorizationStatusCallbackValue: CallbackAuthorizationStatusValue?
    func  authStatusCallback(_ value: CallbackAuthorizationStatusValue?) {
        authorizationStatusCallbackValue = value
    }
    
    // MARK: - 开始定位
    public func start(placemark: @escaping (CLPlacemark) -> Void) {
        FFLocationManager.shared.placemark = placemark
        FFLocationManager.shared.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        FFLocationManager.shared.locationManager.distanceFilter = 100
        let status  = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            FFLocationManager.shared.locationManager.requestWhenInUseAuthorization()
        }
        if status == .restricted {
            FFLocationManager.shared.locationManager.requestWhenInUseAuthorization()
        }
        if status == .denied {
            FFLocationManager.shared.locationManager.requestWhenInUseAuthorization()
        }
        FFLocationManager.shared.locationManager.delegate = self
        if (CLLocationManager.locationServicesEnabled()) {
            FFLocationManager.shared.locationManager.stopUpdatingLocation()
            FFLocationManager.shared.locationManager.startUpdatingLocation()
            FFPrint("定位开始")
        }
    }
    
    private func reverseGeocode(location: CLLocation) {
        LonLatToCity()
    }
    
    ///将经纬度转换为城市名
    private func LonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currLocation) { (placemark, error) -> Void in
            if(error == nil) {
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                //国家
//                let country: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "Country") as! NSString
                //国家编码
                // let CountryCode: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "CountryCode") as! NSString
        
                //省
                let proviceString: String = (mark.addressDictionary! as NSDictionary).value(forKey: "State") as! String
                //城市
                let cityString: String = (mark.addressDictionary! as NSDictionary).value(forKey: "City") as! String
                //区
                let areaString: String = (mark.addressDictionary! as NSDictionary).value(forKey: "SubLocality") as! String
                //具体位置
                let streetString: String = (mark.addressDictionary! as NSDictionary).value(forKey: "Name") as! String
                //完整的位置
//                let formattedAddressLines: NSString = ((mark.addressDictionary! as NSDictionary).value(forKey: "FormattedAddressLines") as AnyObject).firstObject as! NSString
                
//                FFPrint("国家===\(country)")
//                FFPrint("省===\(proviceString)")
//                FFPrint("城市===\(cityString)")
//                FFPrint("区===\(areaString)")
//                FFPrint("街道===\(streetString)")
//                FFPrint("完整位置===\(formattedAddressLines)")
                
                FFMemoryManager.setUserCoordinate(longitude: self.currLocation.coordinate.longitude, latitude: self.currLocation.coordinate.latitude)
                FFMemoryManager.setUserAddress(provice: proviceString, city: cityString, area: areaString, street: streetString)

            } else {
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        currLocation = locations.last!
        FFMemoryManager.setUserCoordinate(longitude:currLocation.coordinate.longitude, latitude:currLocation.coordinate.latitude)


//        let eventDate = currLocation.timestamp
//        let howRecent = eventDate.timeIntervalSinceNow
//        if fabs(howRecent) < 15.0 {
            FFLocationManager.shared.reverseGeocode(location: currLocation)
//        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //用户未选择-->前后台定位授权
        //用户未选择-->被拒绝-->用户真正拒绝-->跳转到设置界面设置允许定位-->前后台定位授权
        if authorizationStatusCallbackValue != nil {
            authorizationStatusCallbackValue!(status)
        }
        switch status {
        case .notDetermined:
            FFPrint("用户未选择")
        case .restricted:
            FFPrint("受限制")
        case.denied:
            FFPrint("被拒绝")
            if CLLocationManager .locationServicesEnabled() {
                FFPrint("用户真正拒绝")
                
//                let alert = UIAlertController(title: "系统提示", message: "定位服务未开启，请进入系统设置-隐私-定位服务中打开开关，并允许应用使用定位服务", preferredStyle: .alert)
//
//                let cancelAction = UIAlertAction(title: "取消", style: .default, handler: { (alertAction) in
//
//                })
//                alert.addAction(cancelAction)
//
//                let okAction = UIAlertAction(title: "设置", style: .default, handler: { (alertAction) in
//                    if #available(iOS 8.0, *) {
//                        let url = NSURL(string: UIApplicationOpenSettingsURLString)
//                        if UIApplication.shared.canOpenURL(url! as URL) {
//                            UIApplication.shared.openURL(url! as URL)
//                        }
//                    }
//                })
//                alert.addAction(okAction)
//
//                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            } else {
                FFPrint("服务未开启")
            }
        case .authorizedAlways:
            FFPrint("前后台定位授权")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                FFLocationManager.shared.locationManager.stopUpdatingLocation()
                FFLocationManager.shared.locationManager.startUpdatingLocation()
            })
        case .authorizedWhenInUse:
            FFPrint("前台定位授权")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                FFLocationManager.shared.locationManager.stopUpdatingLocation()
                FFLocationManager.shared.locationManager.startUpdatingLocation()
            })
        }
    }
}
