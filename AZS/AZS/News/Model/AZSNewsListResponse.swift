//
//  AZSNewsListResponse.swift
//  AZS
//
//  Created by zjixin on 2019/7/10.
//  Copyright © 2019 zjixin. All rights reserved.
//

import UIKit

class AZSNewsImageModel: NSObject {
    var type: String?
    var url: String?
    var width: CGFloat?
    var height: CGFloat?
    
    init(model: Dictionary<String, Any>) {
        self.type = model["type"] as? String
        self.url = model["url"] as? String
        self.width = model["width"] as? CGFloat
        self.height = model["height"] as? CGFloat
    }
}

class AZSNewsInfoModel: NSObject {
    var abstract: String?
    var media_name: String?
    var display_url: String?
    var read_count: NSInteger?
    var image_list: Array<AZSNewsImageModel>?
//    var middle_image: AZSNewsImageModel?
    
    var verified_content: String?
    var title: String?
    var keywords: String?
    var cell_type: NSInteger?
    
    var article_url: String?
    
    init(model: Dictionary<String, Any>) {
        self.abstract = model["abstract"] as? String
        self.media_name = model["media_name"] as? String
        self.display_url = model["display_url"] as? String
        self.read_count = model["read_count"] as? NSInteger
        self.verified_content = model["verified_content"] as? String
        self.title = model["title"] as? String
        self.keywords = model["keywords"] as? String
        self.cell_type = model["cell_type"] as? NSInteger
        self.article_url = model["article_url"] as? String
        let imageList = model["image_list"] as? Array<Dictionary<String, Any>>
        
        var mutaArray = [AZSNewsImageModel].init()
        if imageList != nil {
            for element in imageList! {
                let imageModel = AZSNewsImageModel.init(model: element)
                mutaArray.append(imageModel)
            }
            image_list = mutaArray
        }
    }
}

class AZSNewsSummaryModel: NSObject {
    var content: String?
    var code: NSInteger?
    var infoModel: AZSNewsInfoModel?;
    
    init(model: Dictionary<String, Any>) {
        super.init()
        content = model["content"] as? String
        code = model["code"] as? NSInteger
        if let data = content?.data(using: .utf8) {
            let json = try! JSON.init(data: data)
            let responseObject = json.dictionaryObject
            infoModel = AZSNewsInfoModel.init(model: responseObject!)
        }
    }
}

class AZSNewsListResponse: NSObject {
    var message: String?
    var post_content_hint: String?
    var total_number: NSInteger?
    var data: Array<AZSNewsSummaryModel>?
    
    override init() {
        super.init()
        data = [AZSNewsSummaryModel].init()
    }
    
    func appendContent(content: Dictionary<String, Any>) {
        let data = content["data"] as! Array<Dictionary<String, Any>>
        var mutaArray = [AZSNewsSummaryModel].init()
        for item in data {
            let summaryModel = AZSNewsSummaryModel.init(model: item)
            mutaArray.append(summaryModel)
        }
        self.data = mutaArray
    }
}
