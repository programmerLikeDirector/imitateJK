//
//  UILable+Extension.swift
//  imitateJK
//
//  Created by surenano on 16/10/11.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit


extension UILabel {
    
    convenience init(title: String,textColor: UIColor,fontSize: CGFloat) {
        self.init()
        self.text = title 
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.sizeToFit()
    }
}
