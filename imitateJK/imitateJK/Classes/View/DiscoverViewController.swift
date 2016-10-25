//
//  DiscoverViewController.swift
//  imitateJK
//
//  Created by surenano on 16/10/4.
//  Copyright © 2016年 surenano. All rights reserved.
//
//发现
import UIKit
import MJRefresh
import SVProgressHUD

private let sectionCount = 2

private let reusedStr = "mainCell"
private let topCell = "topCell"

class DiscoverViewController: UITableViewController {
    
    override init(style: UITableViewStyle) {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.creatSubviews()
        
        self.creatRefresh()
        
        self.registerObsever()
        
    }
    
    
    private func creatSubviews () {
        
        self.tableView.sectionFooterHeight = 10
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "小报", target: self, action: #selector(jumpToTabloidPage))
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "front_page_icon_52x18_"))
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "home_search_icon_17x17_", target: self, action: #selector(jumpToSearchPage))
        
        
        self.tableView.register(MainCell.self, forCellReuseIdentifier: reusedStr)
        
        self.tableView.register(TopCell.self, forCellReuseIdentifier: topCell)
        
        self.tableView.rowHeight = 175

    }
    
    //MARK: 简易下拉刷新 原版做不出来。。。
    private func creatRefresh () {
        
        let refresh = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
        
        refresh?.lastUpdatedTimeLabel.isHidden = true
        
        refresh?.setTitle("下拉刷新", for: .idle)
        refresh?.setTitle("松手刷新", for: .pulling)
        refresh?.setTitle("正在刷新", for: .refreshing)
        
        self.tableView.mj_header = refresh
        
    }
    
    @objc private func refreshData() {
        
        self.tableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            
            self.tableView.mj_header.endRefreshing()
            
        }
    }
    
    private func registerObsever(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(jumpToDetailPage(noti:)), name: NSNotification.Name("topicon"), object: nil)
    }
    

    @objc private func jumpToDetailPage(noti:NSNotification){
        
        //通知取值是.userinfo
        let model = noti.userInfo?["data"]
        
        let vc = DetailPageTableViewController()
        
        vc.headData = model as? DiscoverPageCellModel
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: 跳转到小报页面
    @objc private func jumpToTabloidPage (){
        
        
        let transition = CATransition()
        
        transition.type = kCATransitionPush
        
        transition.subtype = kCATransitionFromLeft
        
        let vc = TabloidViewController()
        
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    //MARK: 跳转到搜索页面
    @objc private func jumpToSearchPage (){
        let vc = SearchViewController ()
        

        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return 1
        }else {
            return celldata.count
        }
        
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: topCell, for: indexPath) as! TopCell
            
            cell.upDateClosure = { [weak cell] in
                
                cell?.changeItem()
                
            }
            
            cell.alertNoDate = { [weak cell] (dataArry) in
                
                var arry = [DiscoverPageCellModel]()
                for model in dataArry.reversed() {
                    
                    arry.append(model)
                }
                cell?.data = arry

//                SVProgressHUD.showInfo(withStatus: "没有网络请求，没有新数据")
            }
 
            cell.data = guessLikeData
            
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: reusedStr, for: indexPath) as! MainCell
        
        let data = self.celldata[indexPath.row]
        
        cell.model = data
        
        return cell

    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.section != 0 {
            
            let detailModel = self.celldata[indexPath.row]
            
            let detailVC = DetailPageTableViewController()
            
            detailVC.headData = detailModel
            
            self.navigationController?.pushViewController(detailVC, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = SectionHeadView()
        
        view.section = section
        
        switch section {
        case 0:
            view.text = "猜你喜欢"
        default:
            view.text = "最新主题"
        }
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    
    
    
    lazy var celldata: [DiscoverPageCellModel] = {
        
        let arry = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "DiscoverPlist", ofType: "plist")!)!
        
        var mutableArry = [DiscoverPageCellModel]()
        
        for item in arry {
            
            let model = DiscoverPageCellModel()
            
            model.yy_modelSet(with: item as! [AnyHashable : Any])
            
            mutableArry.append(model)
        }
        
        return mutableArry
        
    }()
    
    
    lazy var guessLikeData: [DiscoverPageCellModel] = {
        
        let path = Bundle.main.path(forResource: "YouLikeJSON", ofType: "json")
        
        let data = NSData.init(contentsOfFile: path!)
        
        let json = try! JSONSerialization.jsonObject(with: data as! Data, options: []) as! [String : Any]
        
        var arry = json["data"] as! NSArray
        
        var mutableArry = [DiscoverPageCellModel]()
        
        for dict in arry {
            
            let model = DiscoverPageCellModel()
            
            model.yy_modelSet(with: dict as! [AnyHashable : Any])
            
            mutableArry.append(model)
        }
        return mutableArry
    }()

    
}
