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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = view.bounds.size.width / 2.0
        
        blueBubble = Bubble(color: .Blue)
        blueBubble!.frame = CGRectMake(center - 60.0, 200.0, 60.0, 60.0)
        view.addSubview(blueBubble!)
        
        yellowBubble = Bubble(color: .Yellow)
        yellowBubble!.frame = CGRectMake(center + 40.0, 220.0, 40.0, 40.0)
        view.addSubview(yellowBubble!)
    }
    
    @IBAction func tap(sender: UITapGestureRecognizer) {
        let touch = sender.locationInView(view)
        if touch.x < view.bounds.size.width / 2.0 {
            BubbleAnimator(originView: blueBubble!, destinationView: yellowBubble!).animate()
        } else {
            BubbleAnimator(originView: yellowBubble!, destinationView: blueBubble!).animate()
        }
    }

}