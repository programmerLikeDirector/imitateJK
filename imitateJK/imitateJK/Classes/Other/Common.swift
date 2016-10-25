//
//  Common.swift
//  imitateJK
//
//  Created by surenano on 16/10/5.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

let client_id = "163263786"
let client_secret = "f15d7f11b4c858306fd8a6eaeaa0a9ab"

let redirect_uri = "https://www.douban.com"


//定义全局的方法 随机色
func randomColor() -> UIColor {
    let r = CGFloat(arc4random() % 256) / 255.0
    let g = CGFloat(arc4random() % 256) / 255.0
    let b = CGFloat(arc4random() % 256) / 255.0
    return UIColor(red: r, green: g, blue: b, alpha: 1)
}

//定义屏幕宽度和高度
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let navBarHeight:CGFloat = 64
