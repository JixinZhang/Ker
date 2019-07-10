//
//  UIViewExtension.swift
//  AZS
//
//  Created by zjixin on 2019/7/10.
//  Copyright © 2019 zjixin. All rights reserved.
//

import UIKit

private var indicatorKey = "UIView.indicatorview"

extension UIView {
    var indicator: UIActivityIndicatorView? {
        get {
            var _indicator: UIActivityIndicatorView? = objc_getAssociatedObject(self, &indicatorKey) as? UIActivityIndicatorView
            if _indicator == nil {
                _indicator = UIActivityIndicatorView.init(style: .gray)
                _indicator?.center = self.center
                _indicator?.hidesWhenStopped = true
                self.addSubview(_indicator!)
                self.bringSubviewToFront(_indicator!)
                objc_setAssociatedObject(self, &indicatorKey, _indicator, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            }
            return _indicator
        }
        
        set {
            objc_setAssociatedObject(self, &indicatorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
}
