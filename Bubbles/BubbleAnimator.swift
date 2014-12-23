//
//  BubbleAnimator.swift
//  Bubbles
//
//  Created by Jelle Vandenbeeck on 23/12/14.
//  Copyright (c) 2014 iCapps. All rights reserved.
//

import UIKit

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
        self.shake(originView)
    }
    
    // MARK: Shake
    
    private func shake(view: UIView) {
        var animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.toValue = 1.15
        animation.delegate = self
        view.layer.addAnimation(animation, forKey: "shake")
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
            self.originView.center = CGPointMake(self.destinationView.center.x - bouncePadding, originCenter.y)
        }) { (success) -> Void in
            UIView.animateWithDuration(BubbleBounceDuration / 2.0, animations: { () -> Void in
                self.destinationView.center = CGPointMake(self.destinationView.center.x + BubbleBouncedOffset, destinationCenter.y)
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