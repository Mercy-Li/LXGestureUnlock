//
//  LXGestureUnlockView.swift
//  LXGestureUnlock
//
//  Created by 李潇 on 15/8/25.
//  Copyright (c) 2015年 李潇. All rights reserved.
//

import UIKit

protocol LXGestureUnlockViewDelegate {
    func gestureViewDidFinish(view: LXGestureUnlockView, code: String)
    func gestureViewDidCancel(view: LXGestureUnlockView)
}

class LXGestureUnlockView: UIView, LXGestureUnlockViewDelegate {
    
    var pointViews = [UIView]()
    
    var verticalMargin: Double   = 10
    var horizontalMargin: Double = 20
    var padding: Double          = 40.0
    let width: Double
    let height: Double
    var diameter: Double
    
    var offColor = UIColor.greenColor()
    var onColor  = UIColor.redColor()
    
    
    override init(frame: CGRect) {
        width = Double(frame.size.width)
        height = Double(frame.size.height)
        diameter = (width-2*horizontalMargin-2*padding)/3.0
        super.init(frame: frame)
        
        self.loadPointViews()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func loadPointViews() {
        for var i = 0; i < 9; i++ {
            var column = i % 3
            var row = i / 3
            
            var pointView = UIView(frame: CGRectMake(0, 0, CGFloat(diameter), CGFloat(diameter)))
            var centerX = width/2.0 + Double(column - 1) * (diameter+padding)
            var centerY = height/2.0 + Double(row-1) * (diameter+padding)
            pointView.center             = CGPointMake(CGFloat(centerX), CGFloat(centerY))
            pointView.layer.cornerRadius = CGFloat(diameter / 2.0)
            pointView.clipsToBounds      = true
            pointView.layer.borderWidth  = 1
            pointView.layer.borderColor  = offColor.CGColor
            
            var point = UIView(frame: CGRectMake(0, 0, CGFloat(diameter / 2), CGFloat(diameter / 2)))
            point.center             = CGPointMake(CGFloat(diameter/2), CGFloat(diameter/2))
            point.layer.cornerRadius = CGFloat(diameter / 2.0)
            point.clipsToBounds      = true
            point.backgroundColor    = offColor
            point.hidden             = true
            
            pointView.addSubview(point)
            pointViews.append(pointView)
            self.addSubview(pointView)
        }
    }
    
    func reset() {
        
    }
    
    func setOn(isOn: Bool, index: Int) {
//        if let view = pointViews[index] {
//            view.layer.borderColor = isOn ? onColor.CGColor : offColor.CGColor
//        }
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        
    }
    
    func gestureViewDidFinish(view: LXGestureUnlockView, code: String) {
        
    }
    
    func gestureViewDidCancel(view: LXGestureUnlockView) {
        
    }
}
