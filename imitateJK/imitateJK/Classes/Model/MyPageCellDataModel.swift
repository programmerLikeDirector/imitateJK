//
//  MyPageCellDataModel.swift
//  imitateJK
//
//  Created by surenano on 16/10/5.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class MyPageCellDataModel: NSObject {
    
    var text : String?
    
    var icon : String?
    
    var detail : String?
    
    var click : String?
    
    init(dict: [String:Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
