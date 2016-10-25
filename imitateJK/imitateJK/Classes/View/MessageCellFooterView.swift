//
//  MessageCellFooterView.swift
//  imitateJK
//
//  Created by surenano on 16/10/18.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

class MessageCellFooterView: UIView {
    
    var isSelected : Bool? = false
    
    var valueIndex : Int? = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        creatSubButtons(imageName: "like_star_border_20x20_",selectedImage: "like_star_20x20_")
        creatSubButtons(imageName: "comment_button_20x20_",selectedImage: "comment_button_20x20_")
        creatSubButtons(imageName: "message_share_20x20_",selectedImage: "message_share_20x20_")
        
    }
    
    private func creatSubButtons (imageName: String ,selectedImage: String) {

        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named:imageName), for: .normal)
        
        
        btn.setImage(UIImage(named:selectedImage), for: .selected)
        
        
        self.addSubview(btn)
        
    }
    
    @objc private func selectedBtn (btn: UIButton) {
      

        let animation = CABasicAnimation()

        animation.keyPath = "transform.scale"
        
        animation.fromValue = valueIndex
        
        if isSelected! {
            
            btn.imageView?.isHidden = false

            
            animation.toValue = 0
            valueIndex = 0
            
            isSelected = false
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                btn.isSelected = false
            })


        }else{
            isSelected = true
            btn.isSelected = true
            animation.toValue = 1
            valueIndex = 1
        }

        animation.duration = 0.25
        btn.imageView?.layer.add(animation, forKey: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnW : CGFloat = 20
        
        let btnH : CGFloat = 20
        
        let margin: CGFloat = 50
        
        var index: CGFloat = 0
        
        for btn in self.subviews {
            
            let btnX = (index + 1) * margin + index * btnW
            
            btn.frame = CGRect(x: btnX, y: 8, width: btnW, height: btnH)
            
            if index == 0 {
                (btn as! UIButton).addTarget(self, action: #selector(selectedBtn(btn:)), for: .touchUpInside)
            }
            
            index += 1
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
