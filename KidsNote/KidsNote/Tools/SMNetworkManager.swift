//
//  SMNetworkManager.swift
//  SinaMall
//
//  Created by 王宇浩 on 2018/8/1.
//  Copyright © 2018年 王宇浩. All rights reserved.
//

import UIKit
import BYToolModule
import Alamofire

private var manager:SessionManager?


///网络请求工具
class SMNetworkManager: NSObject {
    
    static let shared = SMNetworkManager.init()
    private override init() {
        super.init()
    }
    
    /**请求封装，参数用JSON格式传递*/
    final class func networkWithJson(_ method:HTTPMethod, requestURL:String,parameters:[String:Any],showToastAlert:Bool = true, success:@escaping (_ json: AnyObject?)->(), failure:@escaping (_ error : String)->()) {
        SMNetworkManager.configSessions()
        if showToastAlert {
            SMWrongAlert.showRunning()
        }
        manager?.request(requestURL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseData) in
            SMWrongAlert.hide()
            FFPrint("请求接口=\(requestURL) \n 请求参数=\(parameters) \n 获取到Json数据=\(responseData) ")
            SMNetworkManager.dealJsonResponse(responseData, success: { (data) in
                success(data)
            }, failure: { (error) in
                failure(error)
            })
        }
    }
    

    /**处理Response*/
    private class func dealJsonResponse(_ response: DataResponse<Any>, success:@escaping (_ json: AnyObject?)->(), failure:@escaping (_ error : String)->()) {
        switch response.result {
        case .success:
            
            //处理后台返回来的数据
            if let responseDic = response.result.value as? [String : Any],
                let results = responseDic["results"] {
                success(results as AnyObject)
//                let model = SMResponseModel.deserialize(from: responseDic)
//                if model?.code == "00000000" {
//                    //获取数据成功
//                    if let contentData = model?.data {
//                        if contentData.isKind(of: NSArray.classForCoder()) || contentData.isKind(of: NSDictionary.classForCoder()) || (contentData as? String) != nil {
//                            success(contentData)
//                        } else {
//                            success(nil)
//                        }
//                    } else {
//                        success(nil)
//                    }
//                }else {
//                    SMWrongAlert.show(model?.message ?? "")
//                    //其他错误，待处理
//                    if let errorStr=model?.message {
//                        failure(errorStr)
//                    }
//                }
            }
            
        case .failure(_):
            SMWrongAlert.hide()
            SMWrongAlert.show("请求超时，请检查您的网络")
            failure("")
        }
    }
    
    /** 配置*/
    private class func configSessions() {
        if manager == nil {
            let config:URLSessionConfiguration = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 30
            manager = SessionManager(configuration: config)
        }
    }
}
