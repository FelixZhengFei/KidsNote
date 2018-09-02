//
//  UILabel+Helper.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/9/2.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import Foundation
extension UILabel{
    
    open var verticalText : String{
        set{
            let verticalTextKey = UnsafeRawPointer.init(bitPattern: "verticalTextKey".hashValue)
            objc_setAssociatedObject(self,verticalTextKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            let str = NSMutableString(string: verticalText)
            for var i in 0..<str.length*2-1{
                if i%2 != 0 {
                    str.insert("\n", at: i)
                }
                i+=1
            }
            self.numberOfLines = 0

            self.text = str as String

            
        }
        get{
            let verticalTextKey = UnsafeRawPointer.init(bitPattern: "verticalTextKey".hashValue)
            return objc_getAssociatedObject(self, verticalTextKey!) as! String
        }
    }
    
}
