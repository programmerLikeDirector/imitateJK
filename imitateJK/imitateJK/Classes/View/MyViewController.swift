//
//  MyViewController.swift
//  imitateJK
//
//  Created by surenano on 16/10/4.
//  Copyright © 2016年 surenano. All rights reserved.
//
//我的
import UIKit

private let reused = "Mycell"

class MyViewController: UITableViewController {
    
    lazy var cellDataArray : [MyPageCellGroup] = {
        
        
        return MyPageCellGroup.cellDataArray(plistName: "MyMainPlist")
                
    }()
    

    override init(style: UITableViewStyle) {
        super.init(style: UITableViewStyle.grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "settings_icon_16x16_", target: self, action: #selector(jumpToSettingPage))
        

        self.tableView.isUserInteractionEnabled = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reused)
        
        
    }
    
    @objc private func jumpToSettingPage(){
        let vc = MySettingViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return cellDataArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = cellDataArray[section].cellInfo
        
        return (data?.count)!
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reused, for: indexPath)

        let group = cellDataArray[indexPath.section]
        let data = group.cellInfo?[indexPath.row] as!MyPageCellDataModel
        
        if indexPath.row == 0 && indexPath.section == 0{
            cell.backgroundColor = #colorLiteral(red: 0.9125851393, green: 0.9121158123, blue: 0.9303563237, alpha: 1)
            tableView.rowHeight = 100
        }else{
            tableView.rowHeight = 50
        }
        
        cell.selectionStyle = .none
        cell.textLabel?.text = data.text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.imageView?.image = UIImage(named: data.icon!)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        //MARK:根据plist内容跳转页面
        let group = cellDataArray[indexPath.section]
        let data = group.cellInfo?[indexPath.row] as!MyPageCellDataModel
        
        if (data.click?.lengthOfBytes(using: .utf8))! > 0 {
            

            let productName = Bundle.main.infoDictionary!["CFBundleName"] as! String
            let className = productName + "." + data.click!
            
            let vcName = NSClassFromString(className) as! UIViewController.Type
            
            let vc = vcName.init()
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }

    }


    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        }else{
            return 0
        }
    }
}
