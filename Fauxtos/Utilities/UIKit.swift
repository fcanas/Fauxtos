//
//  UIKit.swift
//  Fauxtos
//
//  Created by Fabián Cañas on 8/29/19.
//  Copyright © 2019 Fabián Cañas. All rights reserved.
//

import UIKit

extension UIView {
    /// Recursively finds all instances of UIScrollView in the receivers view tree, including the receiver.
    public func scrollViews() -> [UIScrollView] {
        var svs = subviews.flatMap { $0.scrollViews() }
        if let selfAsScrollView = self as? UIScrollView {
            svs.append(selfAsScrollView)
        }
        return svs
    }
}

extension UIScrollView {
    public func scrollToBottom() {
        self.scrollRectToVisible(CGRect(x: 0, y: self.contentSize.height - 1, width: 1, height: 1), animated: false)
    }
}
