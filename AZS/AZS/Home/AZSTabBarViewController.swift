//
//  AZSTabBarViewController.swift
//  AZS
//
//  Created by zjixin on 2019/7/9.
//  Copyright © 2019 zjixin. All rights reserved.
//

import UIKit

class AZSTabBarViewController: UITabBarController {
    var array: Array<Array<String>>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.array = [ ["首页","home_tabbar_32x32_","home_tabbar_press_32x32_","home_tabbar_night_32x32_","home_tabbar_night_press_32x32_"],
        ["视频","video_tabbar_32x32_","video_tabbar_press_32x32_","video_tabbar_night_32x32_","video_tabbar_night_press_32x32_"],
        ["小视频","weitoutiao_tabbar_32x32_","weitoutiao_tabbar_press_32x32_","weitoutiao_tabbar_night_32x32_","weitoutiao_tabbar_night_press_32x32_"],
        ["未登录","no_login_tabbar_32x32_","no_login_tabbar_press_32x32_","no_login_tabbar_night_32x32_","no_login_tabbar_night_press_32x32_"]
        ]
        
        let newsViewController = AZSNewsViewController.init()
        var item = self.array.first
        var title = item?[0]
        var imageNormal = item![1]
        var imageSelected = item![2]
        newsViewController.tabBarItem.title = title
        newsViewController.tabBarItem.image = UIImage.init(named: imageNormal)
        newsViewController.tabBarItem.selectedImage = UIImage.init(named: imageSelected)
        let newsNavigationController = UINavigationController.init(rootViewController: newsViewController)
        
        let wscnNewsViewController = UIViewController.init()
        wscnNewsViewController.view.backgroundColor = .purple
        item = self.array[1]
        title = item?[0]
        imageNormal = item![1]
        imageSelected = item![2]
        wscnNewsViewController.tabBarItem.title = title
        wscnNewsViewController.tabBarItem.image = UIImage.init(named: imageNormal)
        wscnNewsViewController.tabBarItem.selectedImage = UIImage.init(named: imageSelected)
        let wscnNewsNavigationController = UINavigationController.init(rootViewController: wscnNewsViewController)
        
        self.viewControllers = [newsNavigationController, wscnNewsNavigationController]
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
