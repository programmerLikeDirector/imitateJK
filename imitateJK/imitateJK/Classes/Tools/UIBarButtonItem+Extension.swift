//
//  UIBarButtonItem+Extension.swift
//  imitateJK
//
//  Created by surenano on 16/9/22.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(title: String = "",imageName: String? = nil,target: Any?, action: Selector) {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .highlighted)

        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        if imageName != nil {
            
            btn.setImage(UIImage(named: imageName!), for: .normal)
            btn.setImage(UIImage(named: imageName! + "_highlighted"), for: .highlighted)
        }
        btn.sizeToFit()

        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init()
        
        self.customView = btn
    }
}
