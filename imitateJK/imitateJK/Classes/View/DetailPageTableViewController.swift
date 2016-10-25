//
//  DetailPageTableViewController.swift
//  imitateJK
//
//  Created by surenano on 16/10/11.
//  Copyright © 2016年 surenano. All rights reserved.
//
//主题详情
import UIKit
import SDWebImage
import SVProgressHUD

private let cellID = "cellID"

private let originY :CGFloat = 0
private let originHeight: CGFloat = 320

private let scrollViewHeight: CGFloat = 200
private let backImageHeight : CGFloat = 200



private let screenWidth = UIScreen.main.bounds.width
private let screenHeight = UIScreen.main.bounds.height

class DetailPageTableViewController: UIViewController {
    
    var headData: DiscoverPageCellModel? {
        didSet{
            titleLable.text = headData?.messagePrefix
            
            contentLabel.text = headData?.briefIntro
            
            mainPic.sd_setImage(with: URL(string: headData?.rectanglePicture?.thumbnailUrl ?? ""))
            
            SDWebImageManager.shared().downloadImage(with: URL(string: headData?.squarePicture?.middlePicUrl ?? ""), options: .lowPriority, progress: nil) { (image, error, type, bool, url) in
                
                if error != nil {
                    
                    SVProgressHUD.showInfo(withStatus: "网络有误")
                    
                    return
                }
                
                self.headImage.image = image!.applyLightEffect()
            }
            
        }
    }

    var lastOffSet : CGFloat = 0
    
    var change : CGFloat = 0
    
    var picWidth : CGFloat = 0
    
    var picRect : CGRect = CGRect.zero
    
    var tableView: UITableView = UITableView()
    
    
    lazy var topScrollView: UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 54, width: screenWidth, height: scrollViewHeight))
        
        scroll.isPagingEnabled = true
        scroll.bounces = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        
        return scroll
    }()
    
    lazy var headerView : UIView = {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: originHeight))
        
        header.clipsToBounds = true
        
        return header
        
    }()
    
    lazy var headImage: UIImageView = {
        
        let head = UIImageView()
        
        head.frame = CGRect(x: 0, y: 0, width: screenWidth, height: backImageHeight)
        
        head.contentMode = .scaleAspectFill
        
        return head
    }()
    
    
    lazy var mainPic: UIImageView = {
        let pic = UIImageView()
        
        pic.layer.cornerRadius = 7
        pic.clipsToBounds = true
        
        return pic
    }()
    
    lazy var whiteView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    
    lazy var leftLable: UILabel = {
        let lable = UILabel()
        
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.textColor = UIColor.white
        lable.textAlignment = .center
        
        lable.text = "爆料"
        
        return lable
    }()
    
    lazy var rightLable: UILabel = {
        let lable = UILabel()
        
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.textColor = UIColor.white
        lable.textAlignment = .center
        
        lable.text = "10000关注"
        
        return lable
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        
        button.setBackgroundImage(#imageLiteral(resourceName: "follow_button_55x30_"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "follow_button_highlight_55x30_"), for: .highlighted)
        
        button.addTarget(self, action: #selector(addClick), for: .touchUpInside)
        
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        
        let btn = UIButton()
        
        btn.setBackgroundImage(#imageLiteral(resourceName: "followed_button_55x30_"), for: .normal)
        btn.setBackgroundImage(#imageLiteral(resourceName: "followed_button_highlight_55x30_"), for: .highlighted)
        
        btn.addTarget(self, action: #selector(cancelClick(btn:)), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        
        pc.numberOfPages = 2
        pc.currentPageIndicatorTintColor = UIColor.white
        pc.currentPage = 0
        pc.pageIndicatorTintColor = UIColor.lightGray
        //pc.backgroundColor = UIColor.clear
        
        return pc
    }()
    
    internal var bacView : UIView = UIView()
    
    lazy var titleLable: UILabel = {
        
        let label = UILabel()
        
        label.text = "萝卜报告有新车评提醒"
        
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.textColor = UIColor.darkGray
        
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        
        label.preferredMaxLayoutWidth = 255
        
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    @objc private func addClick(btn: UIButton) {
        
        btn.removeFromSuperview()
        whiteView.addSubview(cancelButton)
        cancelButton.isHidden = false
        self.constraintcancelButton()
    }
    
    @objc private func cancelClick(btn: UIButton) {
        
        btn.removeFromSuperview()
        whiteView.addSubview(addButton)
        addButton.isHidden = false
        self.constraintAddButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatSubviews()
     
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    private func creatSubviews () {
        
        
        let table = UITableView()
        
        self.tableView = table
        
        self.view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
        
        table.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self.view)
        }
    
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

        self.automaticallyAdjustsScrollViewInsets = false
        
        subViewsConstraints()
       
    }
    
    private func subViewsConstraints() {
        tableView.tableHeaderView = headerView
        
        headerView.alpha = 0.01
        
        let backGroundView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        
        backGroundView.backgroundColor = UIColor.white
        
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 64))
        
        self.view.addSubview(backView)
        
        let mv = UIImageView()
        
        SDWebImageManager.shared().downloadImage(with: URL(string: headData?.squarePicture?.middlePicUrl ?? ""), options: .lowPriority, progress: nil) { (image, error, type, bool, url) in
            
            if error != nil {
                return
            }
            
            mv.image = image!.applyLightEffect()
            
        }
        mv.frame.size = self.headImage.frame.size
        mv.contentMode = .scaleAspectFill
        backView.addSubview(mv)
        backView.clipsToBounds = true
        backView.isHidden = true
        
        self.bacView = backView
        
        
        backGroundView.addSubview(headImage)
        
        
        backGroundView.addSubview(pageControl)
        
        
        backGroundView.addSubview(whiteView)
        
        whiteView.addSubview(titleLable)
        
        backGroundView.addSubview(topScrollView)
        
        whiteView.addSubview(cancelButton)
        whiteView.addSubview(addButton)
        
        
        
        topScrollView.contentSize = CGSize(width: 2*screenWidth, height: 0)
        
        topScrollView.addSubview(mainPic)
        topScrollView.addSubview(leftLable)
        topScrollView.addSubview(rightLable)
        topScrollView.addSubview(contentLabel)
        
        //MARK: topScrollview添加监听者
        topScrollView.addObserver(self, forKeyPath: "contentOffset", options: .new , context: nil)
        
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(backGroundView)
            make.top.equalTo(backGroundView).offset(20)
        }
        
        
        
        whiteView.snp.makeConstraints { (make) in
            make.top.equalTo(headImage.snp.bottom)
            make.left.right.equalTo(headImage)
            make.height.equalTo(120)
        }
        
        
        titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(whiteView).offset(50)
            make.right.equalTo(whiteView).offset(-50)
            make.centerY.equalTo(whiteView).offset(-30)
        }
        
        
        
        tableView.backgroundView = backGroundView
        
        
        mainPic.frame = CGRect(x: 0, y: 0, width: 100, height: 160)
        mainPic.layer.position = CGPoint(x: 165, y: 0)
        mainPic.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topScrollView).offset(screenWidth + 30)
            make.top.equalTo(topScrollView).offset(20)
        }
        
        leftLable.snp.makeConstraints { (make) in
            make.left.equalTo(topScrollView).offset(30)
            make.top.equalTo(topScrollView).offset(100)
        }
        
        rightLable.snp.makeConstraints { (make) in
            make.right.equalTo(mainPic.snp.right).offset(85)
            make.top.equalTo(topScrollView).offset(100)
        }
        
        
        constraintAddButton()
        
        constraintcancelButton()

    }
    
    private func constraintAddButton() {
        
        addButton.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(whiteView.snp.centerX)
            make.top.equalTo(whiteView).offset(60)
        }
    }
    
    private func constraintcancelButton() {
        cancelButton.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(whiteView.snp.centerX)
            make.top.equalTo(whiteView).offset(60)
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let offSetX = topScrollView.contentOffset.x
        
        pageControl.currentPage = offSetX >= screenWidth ? 1 : 0
    }

    deinit {
        
        self.topScrollView.removeObserver(self, forKeyPath: "contentOffset")
    }

    
}

extension DetailPageTableViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.backgroundColor = #colorLiteral(red: 0.7895182967, green: 0.8370881081, blue: 0.8707719445, alpha: 1)
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var headImageRect = self.headImage.frame
        
        let offSetY = self.tableView.contentOffset.y

        
        topScrollViewAlpha(offSet: offSetY)
        
        hideButtons(offSet: offSetY)
        
        
        if offSetY > lastOffSet && offSetY > 0 {

            
            UIView.animate(withDuration: 0.5, animations: {
                self.topScrollView.contentOffset = CGPoint.zero
            })
            
            
            if offSetY < 64 {
                
                mainPic.transform = CGAffineTransform(scaleX: 1 - offSetY*0.007, y: 1 - offSetY*0.006)
                
                whiteView.snp.updateConstraints({ (make) in
                    make.top.equalTo(headImage.snp.bottom).offset(-offSetY * 0.6)
                })
                
            }else if offSetY < originHeight - 96 && offSetY > 64 {
                
                
                
                picLevel(offSet: offSetY)
                
                whiteView.snp.updateConstraints({ (make) in
                    make.top.equalTo(headImage.snp.bottom).offset(-offSetY * 0.6)
                })
                
                
                
            }else if offSetY >= originHeight - 96{
                
                mainPic.isHidden = true
                
                
            }
            
            
        }else if offSetY > 0 {

            
            if offSetY < originHeight - 96 && offSetY > 64 {
                
                mainPic.isHidden = false
                
                whiteView.snp.updateConstraints({ (make) in
                    make.top.equalTo(headImage.snp.bottom).offset(-offSetY * 0.6)
                })
            }else if offSetY < 64 {
                
                picLevel(offSet: offSetY)
                
                mainPic.transform = CGAffineTransform(scaleX: 1 - offSetY*0.007, y: 1 - offSetY*0.007)
                
                whiteView.snp.updateConstraints({ (make) in
                    make.top.equalTo(headImage.snp.bottom).offset(-offSetY * 0.6)
                })
                
            }
        }else if offSetY < 0 {
            
            //bug 疑惑点
            if offSetY < lastOffSet {
                
                headImageRect.size.height = backImageHeight - offSetY*0.1
                
            }else{
                headImageRect.size.height = backImageHeight + offSetY*0.1
            }
            headImageRect.origin.y = 0
            self.headImage.frame = headImageRect
            
        }
        
        lastOffSet = offSetY
        
        
    }
    
    private func picLevel(offSet: CGFloat) {
        
        if offSet > 64 {
            self.tableView.backgroundView?.bringSubview(toFront: whiteView)
        }else if offSet < 64 {
            self.tableView.backgroundView?.bringSubview(toFront: topScrollView)
        }
        
        
    }
    
    private func hideButtons(offSet: CGFloat) {
        
        if offSet <= 0 {
            bacView.isHidden = true
            
            leftLable.isHidden = false
            rightLable.isHidden = false
            addButton.isHidden = false
            cancelButton.isHidden = false
            
        }else{
            
            bacView.isHidden = false
            
            leftLable.isHidden = true
            rightLable.isHidden = true
            addButton.isHidden = true
            cancelButton.isHidden = true
        }
        
    }
    
    private func topScrollViewAlpha(offSet: CGFloat) {
        
        if offSet == 0 {
            topScrollView.isUserInteractionEnabled = true
        }else{
            
            topScrollView.isUserInteractionEnabled = false
        }
    }
}
