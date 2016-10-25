//
//  WebViewController.swift
//  imitateJK
//
//  Created by surenano on 16/10/18.
//  Copyright © 2016年 surenano. All rights reserved.
//
//网页
import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    
    var url: String?
    
    lazy var webView: UIWebView = {
        
        let web = UIWebView()
        
        web.isOpaque = false
        
        web.backgroundColor = UIColor.white
        
        return web
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }

    override func loadView() {
        super.loadView()
        
        
        self.view = webView
        
        webView.delegate = self
        
        loadWebView()
        
    }
    
    private func loadWebView(){
        
        guard let urlString = self.url else {
            return
        }

        let url = URL(string: urlString)
        
        let req = URLRequest(url: url!)

        webView.loadRequest(req)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}
