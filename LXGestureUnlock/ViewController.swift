//
//  ViewController.swift
//  LXGestureUnlock
//
//  Created by 李潇 on 15/8/25.
//  Copyright (c) 2015年 李潇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var screentWidth = UIScreen.mainScreen().bounds.size.width
        var gestureView = LXGestureUnlockView(frame: CGRectMake(0, 0, screentWidth, screentWidth))
        self.view.addSubview(gestureView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

