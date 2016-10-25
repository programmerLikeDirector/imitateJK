//
//  CustomLoadmoreButton.swift
//  imitateJK
//
//  Created by surenano on 16/10/17.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class CustomLoadmoreButton: UIButton {

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let xx = titleLabel?.frame.maxX

        return CGRect(x: xx!, y: 0, width:16, height: 16)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        return CGRect(x: 0, y: 0, width: 25, height: 16)
    }

}
