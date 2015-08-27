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

class LXGestureUnlockView: UIView {
    
    var pointViews = [UIView]()
    
    var verticalMargin: Double   = 10
    var horizontalMargin: Double = 20
    var padding: Double          = 40.0
    let width: Double
    let height: Double
    var diameter: Double
    
    var offColor = UIColor.greenColor()
    var onColor  = UIColor.redColor()
    
    var isDrawing = false
    
    var drawingPoints = [UIView]()
    var codes = String()
    var currentPoint: CGPoint?
    
    var delegate: LXGestureUnlockViewDelegate?
    
    override init(frame: CGRect) {
        width = Double(frame.size.width)
        height = Double(frame.size.height)
        diameter = (width-2*horizontalMargin-2*padding)/3.0
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
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
            point.layer.cornerRadius = CGFloat(diameter / 2.0 / 2.0)
            point.clipsToBounds      = true
            point.backgroundColor    = offColor
            point.hidden             = true
            
            pointView.addSubview(point)
            pointViews.append(pointView)
            self.addSubview(pointView)
        }
    }
    
    func reset() {
        for view in pointViews {
            self.setOn(false, view: view)
        }
        isDrawing = false
        codes.removeAll(keepCapacity: false)
        currentPoint = nil
        drawingPoints.removeAll(keepCapacity: false)
        self.setNeedsDisplay()
    }
    
    func setOn(isOn: Bool, view: UIView) {

        var subPoint: UIView = view.subviews[0] as! UIView
        
        view.layer.borderColor = isOn ? onColor.CGColor : offColor.CGColor
        subPoint.backgroundColor = isOn ? onColor : offColor
        
        subPoint.hidden = !isOn
        
    }
    
    func indexOfPoint(point: CGPoint) -> Int? {
        for view in pointViews {
            if view.frame.contains(point) {
                return find(pointViews, view)
            }
        }
        return nil
    }
    
    func updatePoint(point: CGPoint) {
        if let index = self.indexOfPoint(point) {
            var view = pointViews[index]
            if (find(drawingPoints, view) == nil) {
                drawingPoints.append(view)
                self.setOn(true, view: view)
                codes += String(index)
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.reset()
        isDrawing = true
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if isDrawing {
            let point = (touches as NSSet).anyObject()!.locationInView(self)
            currentPoint = point
            self.updatePoint(point)
            self.setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if isDrawing {
            if let d = self.delegate {
                d.gestureViewDidFinish(self, code: codes)
                
            }
            currentPoint = nil
            self.reset()
        }
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        if isDrawing {
            self.reset()
            if let d = self.delegate {
                d.gestureViewDidCancel(self)
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
        if isDrawing {
            var context = UIGraphicsGetCurrentContext()
            for var i = 0; i < drawingPoints.count; i++ {
                var view = drawingPoints[i]
                var center = view.center
                if i == 0 {
                    CGContextMoveToPoint(context, center.x, center.y)
                } else {
                    var lastPoint = drawingPoints[i].center
                    CGContextAddLineToPoint(context, lastPoint.x, lastPoint.y)
                }
                if (i == drawingPoints.count-1) {
                    if let cp = currentPoint {
                        CGContextAddLineToPoint(context, cp.x, cp.y)
                    }
                }
            }
//            for view in pointViews {
//                println(view.frame)
//                var clipPath = UIBezierPath(roundedRect: view.frame, cornerRadius: CGFloat(diameter/2.0))
//                clipPath.addClip()
//                
//            }
        
            
            CGContextSetStrokeColorWithColor(context, onColor.CGColor)
            CGContextSetLineWidth(context, 5)
            CGContextStrokePath(context)
            
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            for view in pointViews {
                CGContextFillEllipseInRect(context, view.frame)
            }
        }
    }
    
    
}
