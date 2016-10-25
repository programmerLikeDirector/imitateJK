//
//  NetWorksTools.swift
//  imitateJK
//
//  Created by surenano on 16/10/4.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPMethod {
    case POST
    case GET
}

class NetWorksTools: AFHTTPSessionManager {
    
    static let sharedTools : NetWorksTools = {
        
        let tools = NetWorksTools()
        
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
    
    
    func request(method: HTTPMethod, urlString: String, parameters: Any?,finished: @escaping (Any?,Error?)->()) {
        
        let successCallBack = { (task: URLSessionDataTask,responseObject: Any?)->() in
            
            finished(responseObject,nil)
        }
        
        let failureCallBack = { (task: URLSessionDataTask?, error: Error) -> () in
            //输出错误信息
            
            finished(nil, error)
        }
        
        if method == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
        
    }
}
