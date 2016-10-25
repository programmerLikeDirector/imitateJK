//
//  BaseNavigationController.swift
//  imitateJK
//
//  Created by surenano on 16/10/4.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //屏幕边缘侧滑回上一页面  遵守UIGestureRecognizerDelegate协议
        //实现 gestureRecognizerShouldBegin 协议方法解决根视图边缘侧滑的bug
        
        //          self.interactivePopGestureRecognizer?.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let count = childViewControllers.count
        
        if count > 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "back_icon_18x15_", target: self, action: #selector(back))
            
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count != 1
    }
    

    
    @objc private func back (){
        
        DispatchQueue.main.async {
            self.navigationBar.setBackgroundImage(nil, for: .default)
            self.popViewController(animated: true)
        }
    
    }


}
