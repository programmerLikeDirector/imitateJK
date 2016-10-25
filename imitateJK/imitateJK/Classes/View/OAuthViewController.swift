//
//  OAuthViewController.swift
//  imitateJK
//
//  Created by surenano on 16/10/4.
//  Copyright © 2016年 surenano. All rights reserved.
//
//测试OAuth
import UIKit

class OAuthViewController: UIViewController {
    
    lazy var webView = UIWebView()
    
    override func loadView() {
        
        webView.isOpaque = false
        view = webView
        
        webView.delegate = self

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setNavBar()
        

        loadOAuthPage()
    }
    
    private func setNavBar() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(close))
        
    }
    
    
    @objc private func close() {

        dismiss(animated: true, completion: nil)
    }
    
    private func loadOAuthPage() {
        
        let urlString = "https://api.weibo.com/oauth2/authorize?" + "client_id=" + client_id + "&redirect_uri=" + redirect_uri
        let url = URL(string: urlString)
        let req = URLRequest(url: url!)
        webView.loadRequest(req)
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension OAuthViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.url?.absoluteString ?? ""
        
        let flag = "code="
        
        if urlString.contains(flag) {
            
            let query = request.url?.query ?? ""
            
            let code = (query as NSString).substring(from: flag.characters.count)
            
            
            UserAccountViewModel.sharedAccountViewModel.loadAccessToken(code: code, finished: { (success) in
                
                if !success {
                    print("\n")
                    print("失败")
                    print("\n")
                    return
                }
                
                print("\n")
                print("获取登陆信息成功")
                print("\n")
            })
            
            return false
        }
        
        return true
    }
    
}
