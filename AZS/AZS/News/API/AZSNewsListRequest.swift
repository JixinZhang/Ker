//
//  AZSNewsListRequest.swift
//  AZS
//
//  Created by zjixin on 2019/7/10.
//  Copyright © 2019 zjixin. All rights reserved.
//

import UIKit

class AZSNewsListRequest: NSObject {
    var request: URLRequest?
    init(category: String) {
        super.init()
        let urlString = "https://is.snssdk.com/api/news/feed/v58/?iid=\(TT_IID)&device_id= \(TT_DEVICE_ID)&device_platform=iphone&category=\(category)"
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let requetUrl = URL(string: urlStringEncoded!)
        request = URLRequest.init(url: requetUrl! as URL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        request?.method = .get
    }
}
