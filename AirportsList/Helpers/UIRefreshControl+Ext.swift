//
//  UIRefreshControl+Ext.swift
//  AirportsList
//
//  Created by Yacob Kazal on 6/9/21.
//

import UIKit
extension UIRefreshControl {

    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: false)
        }
        beginRefreshing()
        sendActions(for: .valueChanged)
    }

}
