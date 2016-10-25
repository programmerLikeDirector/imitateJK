//
//  BaseTabBarController.swift
//  imitateJK
//
//  Created by surenano on 16/10/4.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildControllers()

    }
    
    private func addChildControllers(){
        

        addChildViewController(vc: DiscoverViewController(style: .grouped),title: "发现", imageName:"tab1",index:0)
        
        addChildViewController(vc: MessageViewController(style: .grouped), title: "消息", imageName: "tab2", index: 1)
        
        addChildViewController(vc: MyViewController.init(style: UITableViewStyle.grouped), title: "我的", imageName: "tab3", index: 2)
        
    }
    
    private func addChildViewController(vc: UIViewController,title: String,imageName: String,index: Int) {
        
        vc.navigationItem.title = title
        
        vc.tabBarItem.title = title
        
        vc.tabBarItem.tag = index
        
        vc.tabBarItem.image = UIImage(named: imageName + "_icon_unselected_21x21_")
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_icon_selected_21x21_")
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.black], for: .selected)
        
        let nav = BaseNavigationController(rootViewController: vc)
        
        addChildViewController(nav)
        
    }
    
    
    
}
