//
//  MainCell.swift
//  imitateJK
//
//  Created by surenano on 16/10/11.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit
import SDWebImage


class MainCell: UITableViewCell {
    
    var model: DiscoverPageCellModel? {
        
        didSet{
            icon.sd_setImage(with: URL(string: model?.rectanglePicture?.thumbnailUrl ?? ""))
            
            mainLable.text = model?.messagePrefix
            
            contentLable.text = model?.briefIntro
            
            addButton.isHidden = (model?.isFocus)!
            cancelButton.isHidden = !(model?.isFocus)!
        }
    }
    
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 7
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var mainLable: UILabel = {

        let lable = UILabel()
        
        lable.text = "哈哈哈哈哈哈哈哈"
        
        lable.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        lable.numberOfLines = 0
        
        lable.textAlignment = .left
        
        lable.preferredMaxLayoutWidth = 200
        
        return lable
        
    }()
    
    lazy var contentLable: UILabel = {
        
        let lable = UILabel()
        
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textColor = UIColor.lightGray
        
        lable.numberOfLines = 0
        lable.textAlignment = .natural
        
        lable.text = "曾经的明星科技公司twitter近来频频传出被收购传闻，它能否顺利卖身，谁又会成为最终买家"
        
        lable.preferredMaxLayoutWidth = 180
        
        return lable
    }()
    
    lazy var addButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setBackgroundImage(#imageLiteral(resourceName: "follow_button_55x30_"), for: .normal)
        btn.setBackgroundImage(#imageLiteral(resourceName: "follow_button_highlight_55x30_"), for: .highlighted)
        
        btn.addTarget(self, action: #selector(addClick(btn:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var cancelButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setBackgroundImage(#imageLiteral(resourceName: "followed_button_55x30_"), for: .normal)
        btn.setBackgroundImage(#imageLiteral(resourceName: "followed_button_highlight_55x30_"), for: .highlighted)
        
        btn.addTarget(self, action: #selector(cancelClick(btn:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        creatSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }


    private func creatSubviews () {
        
        contentView.addSubview(mainLable)
        contentView.addSubview(icon)
        contentView.addSubview(contentLable)
        contentView.addSubview(cancelButton)
        contentView.addSubview(addButton)
        
        
        mainLable.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(20)
            
        }
        
        addButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(icon.snp.top).offset(-10)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(icon.snp.top).offset(-10)
        }
        
        
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(20)
            make.bottom.equalTo(contentView).offset(-20)
            make.height.equalTo(100)
            make.width.equalTo(70)
        }
        
        contentLable.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(30)
            make.top.equalTo(icon.snp.top).offset(5)
        }
        
    }
    
    
    @objc private func addClick(btn: UIButton) {
    
        btn.isHidden = true
        cancelButton.isHidden = false
        model?.isFocus = true
        
    }
    
    @objc private func cancelClick(btn: UIButton) {
        
        btn.isHidden = true
        addButton.isHidden = false
        model?.isFocus = false
    }

}
