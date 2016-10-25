//
//  MyPageCellGroup.swift
//  imitateJK
//
//  Created by surenano on 16/10/5.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class MyPageCellGroup: NSObject {

    var headerText : String?
    
    var footerText : String?
    
    var cellInfo : NSArray? {

        didSet{
            
            let arry = NSMutableArray()
            
            for model in cellInfo! {
                let data = MyPageCellDataModel(dict: (model as! [String:Any]))
                
                arry.add(data)
            }
            
            cellInfo = arry.copy() as? NSArray
        }
        
    }
    
    
    init(dict: [String:Any]){
        
        super.init()
     
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    class func cellDataArray(plistName: String) -> [MyPageCellGroup] {
        
        let arry = NSArray(contentsOfFile: Bundle.main.path(forResource: plistName, ofType: "plist")!)
        
        let dataArrys = NSMutableArray()
        
        for data in arry! {
            
            let item = MyPageCellGroup(dict: (data as! [String:Any]))
            
            dataArrys.add(item)
            
        }
        return dataArrys.copy() as! [MyPageCellGroup]
    }
    
    
    
}
