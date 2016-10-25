//
//  MessageCellHeaderView.swift
//  imitateJK
//
//  Created by surenano on 16/10/18.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class MessageCellHeaderView: UIView {
    
    lazy var icon: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.image = #imageLiteral(resourceName: "popular_entrance_20x20_")
        
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        
        label.text = "最近热门"
        
        label.textAlignment = .left
        
        label.font = UIFont.systemFont(ofSize: 16)
        
        label.textColor = UIColor.darkGray
        
        return label
    }()
    
    lazy var moreImage: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.image = #imageLiteral(resourceName: "loadmore_icon_6x10_")
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        creatSubViews()
    }
    
    private func creatSubViews () {
        
        self.addSubview(icon)
        self.addSubview(title)
        self.addSubview(moreImage)
        
        
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(25)
            make.top.equalTo(self).offset(9)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(5)
            make.top.equalTo(self).offset(10)
        }
        
        moreImage.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(16)
            make.right.equalTo(self).offset(-20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
