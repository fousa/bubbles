//
//  BubbleAnimator.swift
//  Bubbles
//
//  Created by Jelle Vandenbeeck on 23/12/14.
//  Copyright (c) 2014 iCapps. All rights reserved.
//

import UIKit

let BubbleBouncedPostionOffset: CGFloat = 5.0
let BubbleBouncedOffset: CGFloat = 10.0
let BubbleBounceDuration: NSTimeInterval = 0.15

class BubbleAnimator: NSObject {
    
    private var originView: UIView
    private var destinationView: UIView
    
    // MARK: - Init
    
    init(originView: UIView, destinationView: UIView) {
        self.originView = originView
        self.destinationView = destinationView
        
        super.init()
    }
    
    // MARK: - Animations
    
    func animate() {
        self.shake()
    }
    
    // MARK: Shake
    
    private func shake() {
        var animation = CABasicAnimation(keyPath: "position.y")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.toValue  = originView.center.y - BubbleBouncedPostionOffset
        animation.delegate = self
        originView.layer.addAnimation(animation, forKey: "position")
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.bounce()
    }
    
    // MARK: Bounce
    
    private func bounce() {
        let originCenter = originView.center
        let destinationCenter = destinationView.center
        let bouncePadding = destinationView.frame.size.width / 2.0 + originView.frame.size.width / 2.0
        UIView.animateWithDuration(BubbleBounceDuration, animations: {
            var x = self.originView.center.x
            if self.originView.center.x < self.destinationView.center.x {
                x = self.originView.center.x + bouncePadding
            } else {
                x = self.originView.center.x - bouncePadding
            }
            self.originView.center = CGPointMake(x, originCenter.y)
        }) { (success) -> Void in
            UIView.animateWithDuration(BubbleBounceDuration / 2.0, animations: { () -> Void in
                var x = self.destinationView.center.x
                if self.originView.center.x < self.destinationView.center.x {
                    x = self.destinationView.center.x + BubbleBouncedOffset
                } else {
                    x = self.destinationView.center.x - BubbleBouncedOffset
                }
                self.destinationView.center = CGPointMake(x, destinationCenter.y)
                }) { (success) -> Void in
                    self.bounceBack(originView: self.originView, originLocation: originCenter)
                    self.bounceBack(originView: self.destinationView, originLocation: destinationCenter)
            }
        }
    }
    
    private func bounceBack(#originView: UIView, originLocation: CGPoint) {
        UIView.animateWithDuration(BubbleBounceDuration, animations: { () -> Void in
            originView.center = originLocation
            }) { (success) -> Void in
                
        }
    }
}