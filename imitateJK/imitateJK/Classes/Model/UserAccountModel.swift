//
//  UserAccountModel.swift
//  imitateJK
//
//  Created by surenano on 16/10/5.
//  Copyright © 2016年 surenano. All rights reserved.
//


import UIKit

class UserAccountModel: NSObject,NSCoding {

    var access_token: String?
    

    var expires_in: Int = 0 {
        didSet {

            expires_date = Date(timeIntervalSinceNow: Double(expires_in))
        }
    }
    
    var expires_date: Date?
    

    var uid: String?
    
    //用户名
    var name: String?
    
    //用户头像 180 * 180
    var avatar_large: String?
    
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    

    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(expires_date, forKey: "expires_date")
        
    }
    
    required init?(coder aDecoder: NSCoder) {

        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
    }


}
