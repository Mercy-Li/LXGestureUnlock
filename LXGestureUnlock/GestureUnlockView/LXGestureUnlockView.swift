//
//  LXGestureUnlockView.swift
//  LXGestureUnlock
//
//  Created by 李潇 on 15/8/25.
//  Copyright (c) 2015年 李潇. All rights reserved.
//

import UIKit

extension UIImage {
    static func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContext(CGSizeMake(1, 1))
        var context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, CGRectMake(0, 0, 1, 1))
        
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}

extension UIView {
    func distributeSameSpacingViews(views: [UIView]) {
        // add horizontally constraint
        var horiSpaces = [UIView]()
        for var i = 0; i <= views.count; i++ {
            var v = UIView()
            horiSpaces.append(v)
            self.addSubview(v)
        }
        
        var v0 = horiSpaces[0]
        v0.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            
        }
        
        // add vertically constraint
        
    }
    
}

let MARGIN   =    20
let PADDING  =    20

class LXGestureUnlockView: UIView {
    
    var bgView = UIImageView(image: UIImage.imageWithColor(UIColor.grayColor()))
    var points = [UIView]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame:CGRectZero);
    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}
