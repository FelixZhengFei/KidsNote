//
//  KDBaseMappable.swift
//  FFJsonTest
//
//  Created by 王宇浩 on 2018/8/4.
//  Copyright © 2018年 王宇浩. All rights reserved.
//

import UIKit

import Foundation

fileprivate enum MapError: Error {
    case jsonToModelFail    //json转model失败
    case jsonToDataFail     //json转data失败
    case dictToJsonFail     //字典转json失败
    case jsonToArrFail      //json转数组失败
    case modelToJsonFail    //model转json失败
}

/// 基础Mapp
protocol KDBaseMappable: Codable {
}

/// 基础Mapp 宽展
extension KDBaseMappable {
    
    /**字典转模型对象*/
    public static func mapObjectFromDict<T : KDBaseMappable>(_ dict : [String:Any], _ type:T.Type) throws -> T {
        guard let JSONString = dict.toJSONString() else {
            print(MapError.dictToJsonFail)
            throw MapError.dictToJsonFail
        }
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        print("字典转模型==\(MapError.jsonToModelFail)" )
        throw MapError.jsonToModelFail
    }
    
    
    /**JSONData转模型对象*/
    public static func mapObjectFromJsonData<T : KDBaseMappable>(_ data:AnyObject?, _ type:T.Type) throws -> T {
        if let sData = data {
            guard let jsonData = try? JSONSerialization.data(withJSONObject: sData, options: .prettyPrinted) else {
                print(MapError.jsonToDataFail)
                throw MapError.jsonToDataFail
            }
            let decoder = JSONDecoder()
            if let obj = try? decoder.decode(type, from: jsonData) {
                return obj
            }
        }
        print(MapError.jsonToModelFail)
        throw MapError.jsonToModelFail
    }
    
    /**JSONString转模型对象*/
    public static func mapObjectFromString<T : KDBaseMappable>(_ JSONString : String, _ type:T.Type) throws -> T {
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        print(MapError.jsonToModelFail)
        throw MapError.jsonToModelFail
    }
    
    /**JSONString转模型对象*/
    public static func mapArrayFromString<T : KDBaseMappable>(_ JSONString : String, _ type:T.Type) throws -> Array<T> {
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        if let array = try? decoder.decode([T].self, from: jsonData) {
            return array
        }
        print(MapError.jsonToModelFail)
        throw MapError.jsonToModelFail
    }
    
    /**JSONData转模型数组*/
    public static func mapArrayFromJson<T : KDBaseMappable>(_ data:AnyObject?, _ type:T.Type) throws -> Array<T> {
        if let sData = data {
            guard let jsonData = try? JSONSerialization.data(withJSONObject: sData, options: .prettyPrinted) else {
                print(MapError.jsonToDataFail)
                throw MapError.jsonToDataFail
            }
            let decoder = JSONDecoder()
            if let array = try? decoder.decode([T].self, from: jsonData) {
                return array
            }
        }
        print(MapError.jsonToModelFail)
        throw MapError.jsonToModelFail
    }
    
    /**模型转字典*/
    public func reflectToDict() -> [String:Any] {
        let mirro = Mirror(reflecting: self)
        var dict = [String:Any]()
        for case let (key?, value) in mirro.children {
            dict[key] = value
        }
        return dict
    }
    
    //模型转json字符串
    public func toJSONString() throws -> String {
        if let str = self.reflectToDict().toJSONString() {
            return str
        }
        print(MapError.modelToJsonFail)
        throw MapError.modelToJsonFail
    }
}


extension Array {
    
    /// 数组转字典
    ///
    /// - Returns: string
    public func toJSONString() -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("dict转json失败")
            return nil
        }
        if let newData : Data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            let JSONString = NSString(data:newData as Data,encoding: String.Encoding.utf8.rawValue)
            return JSONString as String? ?? nil
        }
        print("dict转json失败")
        return nil
    }
    
    /// 解析
    ///
    /// - Parameter type: Json
    /// - Returns:数组
    /// - Throws:
    public func mapFromJson<T : Decodable>(_ type:[T].Type) throws -> Array<T> {
        guard let JSONString = self.toJSONString() else {
            print(MapError.dictToJsonFail)
            throw MapError.dictToJsonFail
        }
        guard let jsonData = JSONString.data(using: .utf8) else {
            print(MapError.jsonToDataFail)
            throw MapError.jsonToDataFail
        }
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(type, from: jsonData) {
            return obj
        }
        print(MapError.jsonToArrFail)
        throw MapError.jsonToArrFail
    }
}


extension Dictionary {
    
    /// 转string
    ///
    /// - Returns: String
    public func toJSONString() -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            return nil
        }
        if let newData : Data = try? JSONSerialization.data(withJSONObject: self, options: []) {
            let JSONString = NSString(data:newData as Data,encoding: String.Encoding.utf8.rawValue)
            return JSONString as String? ?? nil
        }
        return nil
    }
}

extension String {
    
    /// 转字典
    ///
    /// - Returns: 字典
    public func toDict() -> [String:Any]? {
        guard let jsonData:Data = self.data(using: .utf8) else {
            return nil
        }
        if let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
            return dict as? [String : Any] ?? ["":""]
        }
        return nil
    }
}
