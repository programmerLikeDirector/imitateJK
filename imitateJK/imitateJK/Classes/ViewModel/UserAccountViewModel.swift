//
//  UserAccountViewModel.swift
//  imitateJK
//
//  Created by surenano on 16/10/05.
//  Copyright © 2016年 itcast. All rights reserved.


import UIKit

private let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")

class UserAccountViewModel: NSObject {
    
    static let sharedAccountViewModel: UserAccountViewModel = UserAccountViewModel()
    

    var userAccount: UserAccountModel? {
        didSet {
        
            let urlString = userAccount?.avatar_large ?? ""
            iconURL = URL(string: urlString)
        }
    }
    
    
    //判断用户是否登录
    var userLogin: Bool {
        if userAccount?.access_token != nil && isExpires == false {
            return true
        }

        return false
    }
    
    var iconURL: URL?
    
    
    //判断用户token是否过期
    var isExpires: Bool {
        
        if userAccount?.expires_date?.compare(Date()) == ComparisonResult.orderedDescending {
            return false
        }

        return true
    }
    
    
    override init() {
        super.init()
        
        self.userAccount = self.loadUserAccount()
        let urlString = userAccount?.avatar_large ?? ""
        iconURL = URL(string: urlString)
    }
    
    internal func loadAccessToken(code: String,finished: @escaping (Bool) -> ()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id" : client_id,
                          "client_secret" : client_secret,
                          "grant_type" : "authorization_code",
                          "code" : code,
                          "redirect_uri" : redirect_uri
        ]

        NetWorksTools.sharedTools.request(method: .POST, urlString: urlString, parameters: parameters) { (responseObject, error) in
            if error != nil {

                finished(false)
                return
            }
            
            

            self.loadUserInfo(dict: responseObject as! [String : Any],finished: finished)
            
        }
    }
    
    
    private func loadUserInfo(dict: [String : Any],finished: @escaping (Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/users/show.json"
        let access_token = dict["access_token"]!
        let uid = dict["uid"]!

        let paramters = ["access_token" : access_token,
                         "uid" : uid]
        NetWorksTools.sharedTools.request(method: .GET, urlString: urlString, parameters: paramters) { (responseObject, error) in
            if error != nil {
                
                finished(false)
                return
            }
            

            var userInfoDict = responseObject as! [String : Any]
            
            for keyValues in dict {
                userInfoDict[keyValues.key] = keyValues.value
            }
            

            let userAccount = UserAccountModel(dict: userInfoDict)

            self.saveUserAccount(userAccount: userAccount)
            
            self.userAccount = userAccount

            finished(true)
            
        }
    }
    
    private func saveUserAccount(userAccount: UserAccountModel)  {

        NSKeyedArchiver.archiveRootObject(userAccount, toFile: path)

    }
    
    private func loadUserAccount() -> UserAccountModel? {
        let userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? UserAccountModel
        return userAccount
    }
    
}
