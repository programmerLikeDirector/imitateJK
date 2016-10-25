//
//  TabloidMessageModel.swift
//  imitateJK
//
//  Created by surenano on 16/10/18.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class TabloidMessageModel: NSObject {

    
    var content: String?
    var title: String?
    var linkUrl: String?
    var comments: String?
    var pictureUrls: [PictureUrlsModel]?
    
    class func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["pictureUrls": PictureUrlsModel.self]
    }
    
    
}

