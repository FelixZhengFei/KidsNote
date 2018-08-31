//
//  KDShiJieModel.swift
//  SinaMall
//
//  Created by 郑强飞 on 2018/8/20.
//  Copyright © 2018年 SinaMall. All rights reserved.
//

import UIKit

class KDShiJieModel: SMBaseMappable {
    var title:String?
    var type:String?
    var imageName:String? //背景图片
    var seasonImage:String? //季节图片
    var startTime:String? //时间
}

class KDShiJieTimeModel: SMBaseMappable {
    
    var yangTimeString:String?
    var title:String?
    var yinTimeString:String?
}
