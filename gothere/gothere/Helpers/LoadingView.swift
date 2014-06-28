//
//  LoadingView.swift
//  gothere
//
//  Created by Alexey Konyakhin on 28/06/14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit

let viewFrame = CGSizeMake(100, 100)
let loadIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
let loadView = UIView()

class LoadingView: NSObject {
    class func ShowLoadingView(vc: UIViewController, show: Bool) {
        if show {
            loadView.frame.size = viewFrame
            loadView.center = vc.view.center;
            loadView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            loadView.layer.cornerRadius = 5
            loadView.addSubview(loadIndicator)
            loadIndicator.center = CGPointMake(loadView.frame.size.width / 2, loadView.frame.size.height / 2)
            loadIndicator.startAnimating()
            vc.view.addSubview(loadView)
        } else if loadView != nil {
            loadView.removeFromSuperview()
        }
    }
}
