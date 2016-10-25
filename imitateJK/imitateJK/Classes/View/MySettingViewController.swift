//
//  MySettingViewController.swift
//  imitateJK
//
//  Created by surenano on 16/10/7.
//  Copyright © 2016年 surenano. All rights reserved.
//
//设置
import UIKit
import SnapKit

private let cellId = "settingCell"

class MySettingViewController: UIViewController {
    
    internal lazy var cellDataArry : [MyPageCellGroup] = {

        return MyPageCellGroup.cellDataArray(plistName: "MySettingPagePlist")
        
    }()
    
    private lazy var tableView : UITableView = {
        
        
        
        let table = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        
        table.delegate = self
        table.dataSource = self
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
    
        creatSubviews()
    }


    private func creatSubviews(){
        
        self.view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
     
        let catImage = UIImageView(image: #imageLiteral(resourceName: "guoguo_142x163_"))
        
        let titelImage = UIImageView(image: #imageLiteral(resourceName: "created_in_shanghai_208x19_"))
        
        let footView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 80))
        
        footView.backgroundColor = UIColor.clear
        
        
        footView.addSubview(titelImage)
        footView.addSubview(catImage)
        
        titelImage.snp.makeConstraints { (make) in
            make.top.equalTo(footView).offset(60)
            make.left.equalTo(footView).offset(55)
            make.height.equalTo(19)
            make.width.equalTo(208)
        }
        
        catImage.snp.makeConstraints { (make) in
            make.top.equalTo(titelImage.snp.bottom).offset(10)
            make.centerX.equalTo(footView.snp.centerX)
        }
        
        tableView.tableFooterView = footView
    }

}

extension MySettingViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellDataArry.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = cellDataArry[section].cellInfo
        
        return (data?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let group = cellDataArry[indexPath.section]
        
        let model = group.cellInfo?[indexPath.row] as! MyPageCellDataModel
        
        cell.textLabel?.text = model.text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.imageView?.image = UIImage(named: model.icon ?? "")
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let group = cellDataArry[section] 
    
        return group.headerText ?? ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
