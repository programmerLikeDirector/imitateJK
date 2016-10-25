//
//  sectionHeadView.swift
//  imitateJK
//
//  Created by surenano on 16/10/17.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class SectionHeadView: UIView {
    
    var section : Int? {
        didSet{
            if section == 1 {
                moreBtn.isHidden = false
            }
        }
    }
    
    var text: String? {
        didSet{
            self.title.text = text
            
        }
    }
    
    lazy var leftView: UIView = {
        
        let left = UIView()
        
        left.layer.cornerRadius = 3
        left.clipsToBounds = true
        
        left.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)

        
        return left
    }()
    
    
    lazy var title: UILabel = {
        
        
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        label.textAlignment = .left
        return label
        
    }()
    
    lazy var moreBtn: CustomLoadmoreButton = {
        
        let btn = CustomLoadmoreButton()
        
        btn.setImage(#imageLiteral(resourceName: "loadmore_icon_black_16x16_"), for: .normal)
        
        btn.setTitle("更多", for: .normal)
        
        btn.titleLabel?.textAlignment = .center
        
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        
        btn.isHidden = true
        
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.layer.borderWidth = 0.1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.creatSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func creatSubviews() {
        
        
        self.addSubview(leftView)
        self.addSubview(title)
        self.addSubview(moreBtn)
        
        
        leftView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(9)
            make.height.equalTo(20)
            make.width.equalTo(3)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(leftView.snp.right).offset(10)
            make.top.equalTo(self).offset(10)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(12)
        }
        
    }
    
}
