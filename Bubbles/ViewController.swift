//
//  ViewController.swift
//  Bubbles
//
//  Created by Jelle Vandenbeeck on 23/12/14.
//  Copyright (c) 2014 iCapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var blueBubble: Bubble?;
    private var yellowBubble: Bubble?;
    
    private var blueDimension: CGFloat = 60.0
    private var yellowDimension: CGFloat = 60.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.19, green:0.3, blue:0.42, alpha:1)
        
        let y = 200.0 as CGFloat
        let center = view.bounds.size.width / 2.0
        
        blueBubble = Bubble(color: .Blue)
        blueBubble!.frame = CGRectMake(0, y, blueDimension, blueDimension)
        blueBubble!.center = CGPointMake(center - 50.0, blueBubble!.center.y)
        view.addSubview(blueBubble!)
        
        yellowBubble = Bubble(color: .Yellow)
        yellowBubble!.frame = CGRectMake(0, y, yellowDimension, yellowDimension)
        yellowBubble!.center = CGPointMake(center + 50.0, yellowBubble!.center.y)
        view.addSubview(yellowBubble!)
        
        // WE LOVE CRAPPY VIEWS!
        var lineView = UIView(frame: CGRectMake(75.0, CGRectGetMaxY(yellowBubble!.frame), view.frame.size.width - 150.0, 1))
        lineView.backgroundColor = UIColor(red:0.35, green:0.42, blue:0.5, alpha:1)
        view.addSubview(lineView)
    }
    
    @IBAction func tap(sender: UITapGestureRecognizer) {
        let touch = sender.locationInView(view)
        if touch.x < view.bounds.size.width / 2.0 {
            BubbleAnimator(originView: blueBubble!, destinationView: yellowBubble!).animate(scale: 1.1)
        } else {
            BubbleAnimator(originView: yellowBubble!, destinationView: blueBubble!).animate(scale: 1.1)
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}