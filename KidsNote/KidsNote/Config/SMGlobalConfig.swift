//
//  SMGlobalConfig.swift
//  SinaMall
//
//  Created by 王宇浩 on 2018/8/1.
//  Copyright © 2018年 SinaMall. All rights reserved.
//
import UIKit
import BYToolModule


//MARK: ************************颜色配置************************

/**主题颜色FF9D0F*/
let SMTHEME_COLOR = UIColor.ff_HexColor(0xFF6262)
/**线-颜色*/
let SMLINE_COLOR = UIColor.ff_HexColor(0xe5e5e5)
/**文本颜色*/
let SMTEXT_COLOR = UIColor.ff_HexColor(0x292B43)
/**按键不可点击颜色fce4bd*/
let SMBUTTON_DIS_COLOR = UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1)
/**app背景颜色*/
let SMApp_BG_COLOR = UIColor.white
let GRACOLOR    = UIColor.ff_HexColor(0xA4A7B4)
let WHITCOLOR   = UIColor.ff_HexColor(0xFFFFFF)


//MARK: ************************常用值配置************************

/**屏幕宽度 */
let MSC_WIDTH:CGFloat = UIScreen.main.bounds.width
/**屏幕高度 */
let MSC_HEIGHT:CGFloat = UIScreen.main.bounds.height
/**导航栏高度 */
let MNavBar_H: CGFloat = FFAppDevicePulgin.navigationBarHeight
/**导航大标题高度 */
let MBiG_Title_H: CGFloat = 44
/**底部Home高度 */
let MHome_Indicator_Height: CGFloat = FFAppDevicePulgin.homeIndicatorHeight
/**Tabar高度 */
let MTabBar_Height: CGFloat = FFAppDevicePulgin.toolBarHeight
/**状态栏高度 */
let MStatusBar_Height: CGFloat = FFAppDevicePulgin.statusBarHeight

let SM_ROOTVC = (UIApplication.shared.keyWindow?.rootViewController! as! SMTabBarVC)
let H3_FONT = UIFont.systemFont(ofSize: 15)
let LINEW = 0.5
let BANN_PI:CGFloat     = (300/375.0)//(H/W)

//MARK: ************************系统配置************************
/**user_agent*/
let SMUser_Agent: String = {
    var user_agent = "App"+"-"+smDevice_System_Name+"-"+smApp_Version
    user_agent+="-"+sSystem_Version+"-"+"Apple"
    user_agent+="-"+FFAppDevicePulgin.deviceModel
    return user_agent
}()

/**系统版本*/
let sSystem_Version:String = UIDevice.current.systemVersion
/**App 版本*/
let smApp_Version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
/**设备系统名称（如：iOS、iPad）*/
let smDevice_System_Name:String = UIDevice.current.systemName


//MARK: ************************Log************************

public func SMPrint<N>(_ message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line) {
    #if DEBUG
        print("\(message)");
    #else
    #endif
}


