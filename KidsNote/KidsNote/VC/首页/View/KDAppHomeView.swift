//
//  KDAppHomeView.swift
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/27.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

import UIKit
import BYToolModule

class KDAppHomeView: UIView,FFLoadXibProtocol {
    
    var dusShuBlcock:(() -> Void)?
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func duShuButtonClicked(_ sender: Any) {
        dusShuBlcock!()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
