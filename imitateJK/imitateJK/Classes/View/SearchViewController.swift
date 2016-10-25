//
//  SearchViewController.swift
//  imitateJK
//
//  Created by surenano on 16/10/4.
//  Copyright © 2016年 surenano. All rights reserved.
//
//搜索
import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.white
        
        creatSubViews()
        
    }
    
    private func creatSubViews () {
        
        let search = UISearchBar(frame: CGRect(x: 0, y: 0, width: 230, height: 30))
        
        search.placeholder = "搜一搜"
        
        search.becomeFirstResponder()
        
        self.navigationItem.leftBarButtonItem?.customView = search
        
            
        //self.navigationItem.titleView = search
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(back))
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2333853245, green: 0.2333917022, blue: 0.2333882451, alpha: 1)
    }
    
    @objc private func back () {
        _ = self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
