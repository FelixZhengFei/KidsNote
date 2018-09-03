//
//  DKMemoryManager.swift
//
//
//  Created by 郑强飞 on 16/10/27.
//  Copyright © 2016年 郑强飞. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import FFToolModule


// MARK:  -DefaultsKeys
extension DefaultsKeys {
    static public  let user_Longitude_defaultkey = DefaultsKey<String?>("user_Longitude_defaultkey")
    static public  let user_Latitude_defaultkey = DefaultsKey<String?>("user_Latitude_defaultkey")
    
    static public  let user_Provice_defaultkey = DefaultsKey<String?>("user_Provice_defaultkey")
    static public  let user_City_defaultkey = DefaultsKey<String?>("user_City_defaultkey")
    static public  let user_CityCode_defaultkey = DefaultsKey<String?>("user_CityCode_defaultkey")
    static public  let user_Area_defaultkey = DefaultsKey<String?>("user_Area_defaultkey")
}


// MARK:  -公用属性

public class DKMemoryManager: NSObject {

    
    //  -longtidue经度
    static public var userLongitude:String {
        get {
            return Defaults[.user_Longitude_defaultkey] ?? "0"
        }
        set {
            Defaults[.user_Longitude_defaultkey] = newValue
        }
    }
    
    //  -latitude 纬度
    static public var userLatitude:String {
        get {
            return Defaults[.user_Latitude_defaultkey] ?? "0"
        }
        set {
            Defaults[.user_Latitude_defaultkey] = newValue
        }
    }
    
    //  -省
    static public var userProvice:String? {
        get {
            return Defaults[.user_Provice_defaultkey]
        }
        set {
            Defaults[.user_Provice_defaultkey] = newValue
        }
    }
    
    //  -市
    static public var userCity:String? {
        get {
            return Defaults[.user_City_defaultkey]
        }
        set {
            Defaults[.user_City_defaultkey] = newValue
        }
    }
    
    //  -区
    static public var userArea:String? {
        get {
            return Defaults[.user_Area_defaultkey]
        }
        set {
            Defaults[.user_Area_defaultkey] = newValue
        }
    }
}

// MARK:  -公用方法
public extension DKMemoryManager {

    //设置用户 -- 地址信息
    static public func setUserAddress(provice: String? = "", city: String? = "", area: String = "", street:String? = "") {
        self.userProvice = provice
        self.userCity = city
        self.userArea = area
    }
    
    //设置用户 -- 经纬度
    static public func setUserCoordinate(longitude: Double = 0, latitude: Double = 0) {
        self.userLongitude = String(format: "%.6f", longitude)
        self.userLatitude = String(format: "%.6f", latitude)
    }
}
