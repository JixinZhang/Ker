//
//  AZSNewsChannelRequest.swift
//  AZS
//
//  Created by zjixin on 2019/7/10.
//  Copyright © 2019 zjixin. All rights reserved.
//

import UIKit

class AZSNewsChannelRequest: NSObject {
    var request: URLRequest?
    override init() {
        let requetUrl = URL.init(string: "https://is.snssdk.com/article/category/get_subscribed/v1/?iid=17769976909")
        request = URLRequest.init(url: requetUrl! as URL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
    }
}
