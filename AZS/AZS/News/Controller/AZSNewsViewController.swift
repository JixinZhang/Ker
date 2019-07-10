//
//  AZSNewsViewController.swift
//  AZS
//
//  Created by zjixin on 2019/7/9.
//  Copyright © 2019 zjixin. All rights reserved.
//

import UIKit

let rightPicCellIdentifier = "AZSLayoutRightPicCell"

class AZSNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var response: AZSNewsChannelResponse?
    var request: AZSNewsChannelRequest?
    
    var listRequet: AZSNewsListRequest?
    lazy var listResponse: AZSNewsListResponse = {
        let listResponse = AZSNewsListResponse.init()
        return listResponse
    }()
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        tableView = UITableView.init()
        tableView.tableFooterView = UIView.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.gray
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(AZSLayoutRightPicCell.self, forCellReuseIdentifier: rightPicCellIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        self.request = AZSNewsChannelRequest.init()
//        requestNewest()
        
        self.requestListNewest()
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listResponse.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AZSLayoutRightPicCell = tableView.dequeueReusableCell(withIdentifier: rightPicCellIdentifier, for: indexPath) as! AZSLayoutRightPicCell
        
        guard let model = self.listResponse.data?[indexPath.row] else {
            return cell
        }
        cell.configCell(model: model.infoModel!)
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let model = self.listResponse.data?[indexPath.row] else {
            return
        }
        
        guard let urlString = model.infoModel?.article_url else {
            return
        }
        let requestURL = URL.init(string: urlString)
        let webViewController = AZSBaseWebViewController.init()
        webViewController.requestURL = requestURL
        webViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webViewController, animated: true)
    }

    //MARK: Request
    
    func requestNewest() {
        let urlRequest = self.request?.request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest!) {[weak self] (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("error = \(error)")
                return
            }
            
            if data != nil{
                let dict: AnyObject! = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as AnyObject
                print(dict!)
                
                let json = try! JSON(data: data!)
                let responseObject = json.dictionaryObject
                self?.response = AZSNewsChannelResponse.init(content: responseObject!)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        dataTask.resume()
    }
    
    func requestListNewest() {
        self.listRequet = AZSNewsListRequest.init(category: "news_hot")
        let urlRequest = self.listRequet?.request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest!) {[weak self] (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("error = \(error)")
                return
            }
            
            if data != nil{
                let dict: AnyObject! = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as AnyObject
                print(dict!)
                
                let json = try! JSON(data: data!)
                let responseObject = json.dictionaryObject
                self?.listResponse.appendContent(content: responseObject!)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        dataTask.resume()
    }
}
