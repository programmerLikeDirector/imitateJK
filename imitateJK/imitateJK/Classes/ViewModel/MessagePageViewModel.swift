//
//  MessagePageViewModel.swift
//  imitateJK
//
//  Created by surenano on 16/10/18.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class MessagePageViewModel: NSObject {
    
    
    static let sharedModel : MessagePageViewModel = MessagePageViewModel()

    lazy var viewModelArry: [MessagePageCellModel] = {

        let path = Bundle.main.path(forResource: "MessageJSON", ofType: "json")
        
        let data = NSData.init(contentsOfFile: path!)
        
        let jsonDict = try! JSONSerialization.jsonObject(with: data as! Data, options: []) as! [String : Any]
        
        let itemArry = jsonDict["data"] as! NSArray
        
        var arry = [MessagePageCellModel]()
        
        for dict in itemArry {
            
            let model = MessagePageCellModel()
            
            model.yy_modelSet(with: dict as! [AnyHashable : Any])
            
            let cell = UINib(nibName: "MessageCell", bundle: nil).instantiate(withOwner: nil, options: nil).last as! MessageCell
            
            let height = cell.rowHeight(model: model)
            
            model.item?.rowHeight = height
            
            arry.append(model)
            
        }
        return arry
    }()
}
