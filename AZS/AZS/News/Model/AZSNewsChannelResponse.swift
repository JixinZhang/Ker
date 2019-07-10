//
//  AZSNewsChannelResponse.swift
//  AZS
//
//  Created by zjixin on 2019/7/10.
//  Copyright © 2019 zjixin. All rights reserved.
//

import UIKit

class AZSNewsChannelItem: NSObject {
    var category: String?
    var web_url: String?
    var flags: String?
    var name: String?
    var tip_new: String?
    var default_add: String?
    var concern_id: String?
    var type: String?
    var icon_url: String?
    
    init(content: Dictionary<String, Any>) {
        super.init()
        self.category = content["category"] as? String
        self.web_url = content["web_url"] as? String
        self.flags = content["flags"] as? String
        self.name = content["name"] as? String
        self.tip_new = content["tip_new"] as? String
        self.default_add = content["default_add"] as? String
        self.concern_id = content["concern_id"] as? String
        self.type = content["type"] as? String
        self.icon_url = content["icon_url"] as? String
    }
}

class AZSNewsChannelResponse: NSObject {
    public var channelItems: Array<AZSNewsChannelItem>?
    
    init(content: Dictionary<String, Any>) {
        super.init()
        self.channelItems = [AZSNewsChannelItem].init()
        
        let data:Dictionary = content["data"] as! Dictionary<String, Any>
        let items: Array = data["data"] as! Array<Dictionary<String, Any>>
        for element in items {
            let item: Dictionary = element as Dictionary<String, Any>
            let channelItem = AZSNewsChannelItem.init(content: item)
            self.channelItems?.append(channelItem)
        }        
    }
}
