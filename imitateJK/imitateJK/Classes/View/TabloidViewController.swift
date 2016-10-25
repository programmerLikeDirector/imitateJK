//
//  TabloidViewController.swift
//  imitateJK
//
//  Created by surenano on 16/10/4.
//  Copyright © 2016年 surenano. All rights reserved.
//
//小报
import UIKit
import SDWebImage

private let backImageHeight : CGFloat = 270

internal let TabloidCellID = "TabloidCell"

class TabloidViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        
        let table = UITableView(frame: self.view.bounds, style: .plain)
        
        return table
    }()
    
    lazy var headerView : UIView = {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: backImageHeight))
        header.backgroundColor = UIColor.clear
        
        header.clipsToBounds = true
        
        return header
        
    }()
    
    lazy var headImage: UIImageView = {
        
        let head = UIImageView()
        
        head.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: backImageHeight)
        
        head.contentMode = .scaleAspectFill
        
        return head
    }()
    
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = 270
    
        return label
    }()
    
    lazy var smallLabel: UILabel = {
        let Lable = UILabel(title: "即刻小报", textColor: UIColor.white, fontSize: 17)
        
        Lable.isHidden = true
        
        return Lable
    }()
    

    
    var navImage : UIView = {
       
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 64))
        
        return view
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        
        view.addSubview(tableView)
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TabloidCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: TabloidCellID)
        
        creatHeadImage()
        
    }

    
    private func creatHeadImage() {
        
        let backGroundView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        
        
        let urlString = URL(string: cellDataArry.picture!)
        
        headImage.sd_setImage(with: urlString)
        
        backGroundView.addSubview(headImage)
        
        self.tableView.backgroundView = backGroundView
        
        self.tableView.tableHeaderView = headerView
        
        let navPic = UIImageView()
        navPic.frame.size = self.headImage.frame.size
        navPic.contentMode = .scaleAspectFill
        SDWebImageManager.shared().downloadImage(with: URL(string: cellDataArry.picture!), options: .lowPriority, progress: nil) { (image, error, type, bool, url) in
            
            if error != nil {
                return
            }
            
            navPic.image = image!.applyLightEffect()
        }
        
        navImage.addSubview(navPic)
        navImage.clipsToBounds = true
        navImage.isHidden = true

        navImage.addSubview(smallLabel)
        
        smallLabel.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(navImage.snp.centerX).offset(-5)
            make.top.equalTo(navImage).offset(30)
            
        }
        
        self.view.addSubview(navImage)
        
        
        self.headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headerView).offset(20)
            make.bottom.equalTo(headerView).offset(-30)
        }
        
        titleLabel.text = cellDataArry.title
        
    }
    
    
    
    lazy var cellDataArry: TabloidViewModel = {
        
        let path = Bundle.main.path(forResource: "TabloidViewJSON", ofType: "json")
        
        let data = NSData.init(contentsOfFile: path!)
        
        let jsonArry = try! JSONSerialization.jsonObject(with: data as! Data, options: []) as! [String : Any]
        
        let model = TabloidViewModel()
        
        model.yy_modelSet(with: jsonArry["data"] as! [String: Any])
        
        
        return model
    }()
    
    

}

extension TabloidViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.cellDataArry.messages?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TabloidCellID, for: indexPath) as! TabloidCell
        
        cell.model = (self.cellDataArry.messages)?[indexPath.row]
        cell.tag = indexPath.row
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let cell = UINib(nibName: "TabloidCell", bundle: nil).instantiate(withOwner: nil, options: nil).last as! TabloidCell
        
        let model = self.cellDataArry.messages?[indexPath.row]
        
        return cell.cellRowHeight(dataModel: model!)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var rect = self.headImage.frame
        
        let offSetY = scrollView.contentOffset.y
        
        if  offSetY > 0 {
            
            rect.origin.y = -offSetY
            self.headImage.frame = rect
            
            if offSetY > backImageHeight - 64 {
                self.navImage.isHidden = false
                self.smallLabel.isHidden = false

            }else{
                self.navImage.isHidden = true

                self.smallLabel.isHidden = true
            }
            
        }else {
            
            rect.origin.y = 0
            
            rect.size.height = backImageHeight - offSetY;
            
            self.headImage.frame = rect
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
 
}

class TabloidCell: UITableViewCell {
    
    
    
    @IBOutlet weak var randomView: UIView!
    
    @IBOutlet weak var index: UILabel!

    @IBOutlet weak var picture: UIImageView!

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!

    @IBOutlet weak var tips: UILabel!
    
    @IBOutlet weak var PicHeight: NSLayoutConstraint!
    
    var model: TabloidMessageModel? {
        didSet{
            
            
            if (model?.pictureUrls?.count)! > 0 {
                
                let urlString = URL(string: model?.pictureUrls?[0].middlePicUrl ?? "")
                picture.sd_setImage(with: urlString)
                PicHeight.constant = 150
                
            }else if (model?.pictureUrls?.count)! <= 0{
                PicHeight.constant = 0
            }
     
            title.text = model?.content
            
            content.text = model?.comments
            
            tips.text = "via " + (model?.title)!
            
        }
    }
    
    override func awakeFromNib() {
        
        randomView.backgroundColor = randomColor()
        randomView.layer.cornerRadius = 10
        randomView.clipsToBounds = true
    }
    
    func cellRowHeight (dataModel: TabloidMessageModel) -> CGFloat {
        
        self.model = dataModel
        self.layoutIfNeeded()
        
        return self.tips.frame.maxY + 20
        
    }
    
    
    
}
