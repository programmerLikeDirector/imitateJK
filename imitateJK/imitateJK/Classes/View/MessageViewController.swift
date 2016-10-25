//
//  MessageViewController.swift
//  imitateJK
//
//  Created by surenano on 16/10/4.
//  Copyright © 2016年 surenano. All rights reserved.
//
//消息
import UIKit

private let  cellID = "MessageCell"

class MessageViewController: UITableViewController {
    
    override init(style: UITableViewStyle) {
        super.init(style: .grouped)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MessageCell", bundle: nil)
        
        self.tableView.register(nib, forCellReuseIdentifier: cellID)
        
        self.tableView.sectionFooterHeight = 0
        self.tableView.sectionHeaderHeight = 0
        
        self.tableView.rowHeight = 200
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return MessagePageViewModel.sharedModel.viewModelArry.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MessageCell

        let data = MessagePageViewModel.sharedModel.viewModelArry[indexPath.section]
        
        cell.cellModel = data

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let model = MessagePageViewModel.sharedModel.viewModelArry[indexPath.section]
        
        return  (model.item?.rowHeight)!
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = MessagePageViewModel.sharedModel.viewModelArry[indexPath.section]
        
        if model.item?.linkUrl != nil {
            
            let webView = WebViewController()
            
            webView.url = model.item?.linkUrl
            
            webView.title = model.item?.topic?.content
            
            self.navigationController?.pushViewController(webView, animated: true)
        }else{
            
        }
        
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        let view = MessageCellFooterView()
        
        return view
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let view = MessageCellHeaderView()
            return view
        }

        let view = UIView()
        
        return view
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 36
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if  section == 0 {
            return 40
        }
        
        return 5
    }

    
}
