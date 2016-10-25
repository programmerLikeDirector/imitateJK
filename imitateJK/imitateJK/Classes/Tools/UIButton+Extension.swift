//
//  UIButton+Extension.swift
//  imitateJK
//
//  Created by surenano on 16/10/11.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,textColor: UIColor,fontSize: CGFloat) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.sizeToFit()
    }
}
