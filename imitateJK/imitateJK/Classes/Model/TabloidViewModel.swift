//
//  TabloidViewModel.swift
//  imitateJK
//
//  Created by surenano on 16/10/18.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit
import YYModel


class TabloidViewModel: NSObject {

    var id: String?
    var title: String?
    var postedAt: String?
    var messages: [TabloidMessageModel]?
    var picture: String?

    class func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["messages": TabloidMessageModel.self]
    }

    
    
}
