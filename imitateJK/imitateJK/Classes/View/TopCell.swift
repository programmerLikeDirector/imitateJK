//
//  TestTopCellTableViewCell.swift
//  imitateJK
//
//  Created by surenano on 16/10/20.
//  Copyright © 2016年 surenano. All rights reserved.
//

import UIKit

private let commonMargin :CGFloat = 20
private let maxCount :CGFloat = 3
private let itemWidth = (ScreenWidth - (maxCount + 1) * commonMargin) / 3

private let iconHeight: CGFloat = 80
private let labelHeight: CGFloat = 30


private let iconCell = "iconCell"
private let labelCell = "labelCell"

class TopCell: UITableViewCell{
    
    var data : [DiscoverPageCellModel]? {
        didSet {

            upDateClosure?()

            self.iconCollectionView.reloadData()
            self.labelCollectionView.reloadData()
            
        }
    }
    
    var upDateClosure: (()->())?
    
    var alertNoDate: ((_ dataArry: [DiscoverPageCellModel])->())?

    private var scrollCount : CGFloat = 0
    
    internal lazy var iconCollectionView: UICollectionView = {
        
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        flowLayout.scrollDirection = .vertical
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: iconHeight)
     
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
    
        view.isScrollEnabled = false
        
        view.showsVerticalScrollIndicator = false
        
        view.backgroundColor = UIColor.white

        view.bounces = false
        
        return view
        
    }()
    
    internal lazy var labelCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        flowLayout.scrollDirection = .vertical
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: labelHeight)
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        
        view.isScrollEnabled = false
        
        
        view.showsVerticalScrollIndicator = false
        
        view.backgroundColor = UIColor.white
        
        view.bounces = false
        
        
        return view
    }()
    
    private lazy var changeButton: UIButton = {
        let btn = UIButton(type: .custom)
        
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.darkGray.cgColor
        
        btn.backgroundColor = UIColor.white
        
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        
        btn.setTitle("换一换", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "change_recommendation_icon_17x17_"), for: .normal)
        
        btn.addTarget(self, action: #selector(changeItem), for: .touchUpInside)
        
        return btn
    }()
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        

        
        creatSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func changeItem () {
        
        scrollicon(scrollOffSet: iconHeight,isAnimation: true)
        
        scrollLabel(scrollOffSet: labelHeight,isAnimation: true)
        
        scrollCount += 1
    }
    
    private func creatSubView () {
       
        contentView.addSubview(iconCollectionView)
        contentView.addSubview(labelCollectionView)
        
        contentView.addSubview(changeButton)
        
        iconCollectionView.delegate = self
        iconCollectionView.dataSource = self
        
        labelCollectionView.delegate = self
        labelCollectionView.dataSource = self
        
        iconCollectionView.register(topiconCell.self, forCellWithReuseIdentifier: iconCell)
        labelCollectionView.register(topLabelCell.self, forCellWithReuseIdentifier: labelCell)
        
        iconCollectionView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-20)
            make.height.equalTo(iconHeight)
        }
        
        labelCollectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(iconCollectionView)
            make.trailing.equalTo(iconCollectionView)
            make.top.equalTo(iconCollectionView.snp.bottom).offset(5)
            make.height.equalTo(labelHeight)
            
        }
        
        changeButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView).offset(-15)
            make.left.equalTo(contentView).offset(90)
            make.right.equalTo(contentView).offset(-90)
            make.height.equalTo(30)
        }

    }
    
    internal func scrollicon (scrollOffSet: CGFloat,isAnimation:Bool) {
            
        let icony = (CGFloat((data?.count)!) / maxCount ) * iconHeight - iconHeight
        
        
        let iconrect = CGRect(x: 0, y: icony - scrollCount * scrollOffSet, width: iconCollectionView.frame.width, height: iconCollectionView.frame.height)

        if scrollCount == 0 {
            iconCollectionView.scrollRectToVisible(iconrect, animated: false)
        }else{
            iconCollectionView.scrollRectToVisible(iconrect, animated: isAnimation)
        }
    
    }

    internal func scrollLabel (scrollOffSet: CGFloat,isAnimation:Bool) {
        
        let labely = (CGFloat((data?.count)!) / maxCount ) * labelHeight - labelHeight
        
        let labelRect = CGRect(x: 0, y: labely - scrollCount * scrollOffSet, width: labelCollectionView.frame.width, height: labelCollectionView.frame.height)

        
        if labelRect.origin.y < 0 {
            
            // 有先后顺序
            scrollCount = 0
            
            alertNoDate?(data!)

            return
        }

        
        if scrollCount == 0 {
            
            labelCollectionView.scrollRectToVisible(labelRect, animated: false)
        }else{
            labelCollectionView.scrollRectToVisible(labelRect, animated: isAnimation)
        }
    }

}

extension TopCell : UICollectionViewDataSource,UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (data?.count) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == iconCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: iconCell, for: indexPath) as! topiconCell
            
            cell.itemData = data?[indexPath.item]
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelCell, for: indexPath) as! topLabelCell
        
        cell.textData = data?[indexPath.item]
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == iconCollectionView   {
            
            DispatchQueue.once(token: "iconCell") {
                
                scrollicon(scrollOffSet: 0,isAnimation: false)
                
            }
            
        }else if collectionView == labelCollectionView && indexPath.item == 0 {
            
            DispatchQueue.once(token: "textCell") {
            
                scrollLabel(scrollOffSet: 0,isAnimation: false)
            }
            
        }
        
    }
    
}

class topiconCell: UICollectionViewCell {
    
    
    var itemData : DiscoverPageCellModel? {
        
        didSet{
            
            let urlString = URL(string: itemData?.squarePicture?.thumbnailUrl ?? "")
            icon.sd_setImage(with: urlString)
            
        }
    }
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.isUserInteractionEnabled = true
        
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(jumpToDetailPage))
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        creatSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func creatSubViews (){
        
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView.snp.edges)
        }
    }
    
    @objc private func jumpToDetailPage () {

       NotificationCenter.default.post(name: NSNotification.Name("topicon"), object: nil, userInfo: ["data":itemData])
    }
    
    
}

class topLabelCell: UICollectionViewCell {
    
    var textData : DiscoverPageCellModel? {
        didSet{
            picText.text = textData?.messagePrefix
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var picText: UILabel = {
        
        let label = UILabel()

        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        
        return label
    }()
    
    private func creatSubView() {
        contentView.addSubview(picText)
        
        picText.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView.snp.edges)
        }
    }
}


