//
//  LocationManager.swift
//  GuanXinBussinessApp
//
//  Created by 郑强飞 on 16/11/28.
//  Copyright © 2016年 郑强飞. All rights reserved.
//


import UIKit
import CoreLocation


public class DKLocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager: CLLocationManager = CLLocationManager()
    private var completed: (() -> Void)? = nil
    var currLocation:CLLocation = CLLocation()
    
    // MARK: - 单例
    public static let shared = DKLocationManager()
    
    private override init() {
        
    }
    
    // MARK: - 回调权限
    typealias CallbackAuthorizationStatusValue = (_ authStatus: CLAuthorizationStatus) -> Void
    private var  authorizationStatusCallbackValue: CallbackAuthorizationStatusValue?
    func  authStatusCallback(_ value: CallbackAuthorizationStatusValue?) {
        authorizationStatusCallbackValue = value
    }
    
    // MARK: - 开始定位
    public func start(_ complete: @escaping () -> Void) {
        completed = complete
        DKLocationManager.shared.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        DKLocationManager.shared.locationManager.distanceFilter = 100
        let status  = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            DKLocationManager.shared.locationManager.requestWhenInUseAuthorization()
        }
        if status == .restricted {
            DKLocationManager.shared.locationManager.requestWhenInUseAuthorization()
        }
        if status == .denied {
            DKLocationManager.shared.locationManager.requestWhenInUseAuthorization()
        }
        DKLocationManager.shared.locationManager.delegate = self
        if (CLLocationManager.locationServicesEnabled()) {
            DKLocationManager.shared.locationManager.stopUpdatingLocation()
            DKLocationManager.shared.locationManager.startUpdatingLocation()
            FFPrint("定位开始")
        }
    }
    
    private func reverseGeocode(location: CLLocation) {
        LonLatToCity()
    }
    
    ///将经纬度转换为城市名
    private func LonLatToCity() {
        weak var weakSelf = self
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
                DKMemoryManager.setUserCoordinate(longitude: self.currLocation.coordinate.longitude, latitude: self.currLocation.coordinate.latitude)
                DKMemoryManager.setUserAddress(provice: proviceString, city: cityString, area: areaString, street: streetString)
                weakSelf?.completed!()
            } else {
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        currLocation = locations.last!
        DKMemoryManager.setUserCoordinate(longitude:currLocation.coordinate.longitude, latitude:currLocation.coordinate.latitude)


//        let eventDate = currLocation.timestamp
//        let howRecent = eventDate.timeIntervalSinceNow
//        if fabs(howRecent) < 15.0 {
            DKLocationManager.shared.reverseGeocode(location: currLocation)
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
            } else {
                FFPrint("服务未开启")
            }
        case .authorizedAlways:
            FFPrint("前后台定位授权")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                DKLocationManager.shared.locationManager.stopUpdatingLocation()
                DKLocationManager.shared.locationManager.startUpdatingLocation()
            })
        case .authorizedWhenInUse:
            FFPrint("前台定位授权")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                DKLocationManager.shared.locationManager.stopUpdatingLocation()
                DKLocationManager.shared.locationManager.startUpdatingLocation()
            })
        }
    }
}
