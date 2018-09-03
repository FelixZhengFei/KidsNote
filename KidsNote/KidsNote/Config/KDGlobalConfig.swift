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

//MARK: ************************常用值配置************************

/**屏幕宽度 */
let kScreen_WIDTH:CGFloat = UIScreen.main.bounds.width
/**屏幕高度 */
let kScreen_HEIGHT:CGFloat = UIScreen.main.bounds.height
/**导航栏高度 */
let kNavBar_H: CGFloat = FFAppDevicePulgin.navigationBarHeight
/**底部Home高度 */
let kHome_Indicator_Height: CGFloat = FFAppDevicePulgin.homeIndicatorHeight
/**Tabar高度 */
let kTabBar_Height: CGFloat = FFAppDevicePulgin.toolBarHeight
/**状态栏高度 */
let kStatusBar_Height: CGFloat = FFAppDevicePulgin.statusBarHeight

//MARK: ************************Log************************

public func FFPrint<N>(_ message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line) {
    #if DEBUG
        print("\(message)");
    #else
    #endif
}


