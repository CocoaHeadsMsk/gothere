//
//  GAlertView.swift
//  gothere
//
//  Created by Alexey Konyakhin on 29/06/14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit

class GAlertView: UIView {

    init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = bounds
        addSubview(effectView)
    }

}
