//
//  AZSBaseWebViewController.swift
//  AZS
//
//  Created by zjixin on 2019/7/10.
//  Copyright © 2019 zjixin. All rights reserved.
//

import UIKit
import WebKit

class AZSBaseWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var wkWebView: WKWebView!
    var requestURL: URL?
    var progress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.loadDefaultRequest()
    }
    
    func loadDefaultRequest() {
        if self.requestURL != nil && self.isViewLoaded {
            var mutaRequest = URLRequest.init(url: self.requestURL!)
            mutaRequest.cachePolicy = .reloadIgnoringLocalCacheData
            self.wkWebView?.load(mutaRequest)
        }
    }
    
    func initView() {
        self.wkWebView = WKWebView.init(frame: self.view.bounds, configuration: configuration())
        self.wkWebView.uiDelegate = self
        self.wkWebView.navigationDelegate = self
        self.wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.view.addSubview(self.wkWebView)

        self.wkWebView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(KNavHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.progress = UIProgressView.init()
        self.progress.isHidden = false
        self.progress.progressTintColor = .red
        self.progress.trackTintColor = .white
        self.progress.backgroundColor = .white
        self.view.addSubview(self.progress)
        self.progress.transform = CGAffineTransform.init(scaleX: 1, y: 1.0)
        self.progress.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(KNavHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(4)
        }
    }
    
    func configuration() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration.init()
        let preferences = WKPreferences.init()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        configuration.preferences = preferences
        return configuration
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.wkWebView.indicator?.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
        self.wkWebView.indicator?.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.wkWebView.indicator?.stopAnimating()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let newValue = change?[.newKey] as? CGFloat
            if self.wkWebView.estimatedProgress >= 1 {
                self.progressDidFinishLoad()
            } else {
                self.progress.isHidden = false
                self.progress.progress = Float(self.wkWebView.estimatedProgress)
            }
        }
    }
    
    func progressDidFinishLoad() {
        self.progress.progress = 1.0
        UIView.animate(withDuration: 0.25, delay: 0.3, animations: {
            self.progress.transform = CGAffineTransform.init(scaleX: 1, y: 0.9)
        }) { (finish) in
            self.progress.isHidden = true
            self.progress.transform = CGAffineTransform.init(scaleX: 1, y: 1.0)
        }
    }
}
