//
//  MessageItemModel.swift
//  imitateJK
//
//  Created by surenano on 16/10/18.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class MessageItemModel: NSObject {
    
    var content: String?
    var title: String?
    var linkUrl: String?
    var createdAt: String?
    var topic: MessageTopicModel?
    var pictureUrls: [PictureUrlsModel]?
    var video: MessageVideoModel?
    
    var rowHeight: CGFloat? = 100
    
    class func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["pictureUrls": PictureUrlsModel.self]
    }
    
}
