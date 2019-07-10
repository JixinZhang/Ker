//
//  AZSPrefixHeader.swift
//  AZS
//
//  Created by zjixin on 2019/7/9.
//  Copyright © 2019 zjixin. All rights reserved.
//


import Foundation
import UIKit

@_exported import WebKit

@_exported import Alamofire
@_exported import SwiftyJSON
@_exported import SnapKit
@_exported import Kingfisher

let KScreenWidth = UIScreen.main.bounds.width
let KScreenHeight = UIScreen.main.bounds.height

let KDevice_iPhoneXSeries = (__CGSizeEqualToSize(CGSize.init(width: 375.0, height: 812.0), UIScreen.main.bounds.size) || __CGSizeEqualToSize(CGSize.init(width: 414.0, height: 896.0), UIScreen.main.bounds.size))

let KNavHeight = (KDevice_iPhoneXSeries ? 88.0 : 64.0)
let KTabBarHeight = (KDevice_iPhoneXSeries ? 83.0 : 49.0)
let KStatusBarHeight = (KDevice_iPhoneXSeries ? 44.0 : 20.0)
let KBottomMargin = (KDevice_iPhoneXSeries ? 34.0 : 0)

let TT_IID = "17769976909"
let TT_DEVICE_ID = "41312231473"

