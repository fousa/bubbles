//
//  BubbleAnimator.swift
//  Bubbles
//
//  Created by Jelle Vandenbeeck on 23/12/14.
//  Copyright (c) 2014 iCapps. All rights reserved.
//

import UIKit

let BubbleBouncedPostionOffset: CGFloat = 5.0
let BubbleBouncedOffset: CGFloat = 5.0
let BubbleBounceDuration: NSTimeInterval = 0.25

class BubbleAnimator: NSObject {
    
    private var originView: UIView
    private var destinationView: UIView
    private var scale: CGFloat?
    
    // MARK: - Init
    
    init(originView: UIView, destinationView: UIView) {
        self.originView = originView
        self.destinationView = destinationView
        
        super.init()
    }
    
    // MARK: - Animations
    
    func animate(#scale: CGFloat) {
        self.scale = scale
        self.shake(scale: scale)
    }
    
    // MARK: Shake
    
    private func shake(#scale: CGFloat) {
        UIView.animateWithDuration(0.35, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .CurveEaseInOut, animations: { () -> Void in
            let heightRatio = (self.originView.layer.frame.size.height - (scale * self.originView.frame.size.height))
            let widthRatio = (self.originView.layer.frame.size.width - (scale * self.originView.frame.size.width))
            
            let y = self.originView.frame.origin.y + heightRatio
            var x = self.originView.frame.origin.x
            if self.originView.center.x < self.destinationView.center.x {
                x += widthRatio
            } else {
                x -= widthRatio
            }
                self.originView.frame = CGRectMake(x, y, self.originView.frame.size.width * scale, self.originView.frame.size.height * scale)
        }) { (success) -> Void in
            self.bounce()
        }
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.bounce()
    }
    
    // MARK: Bounce
    
    private func bounce() {
        let originCenter = originView.center
        let destinationCenter = destinationView.center
        let bouncePadding = destinationView.layer.bounds.size.width / 2.0 + originView.layer.bounds.size.width / 2.0
        UIView.animateWithDuration(BubbleBounceDuration, animations: {
            var x = self.originView.center.x
            if self.originView.center.x < self.destinationView.center.x {
                x = self.destinationView.center.x - bouncePadding
            } else {
                x = self.destinationView.center.x + bouncePadding
            }
            self.originView.center = CGPointMake(x, originCenter.y)
        }) { (success) -> Void in
            UIView.animateWithDuration(BubbleBounceDuration * 1.2, animations: { () -> Void in
                var x = self.destinationView.center.x
                if self.originView.center.x < self.destinationView.center.x {
                    x = self.destinationView.center.x + BubbleBouncedOffset
                } else {
                    x = self.destinationView.center.x - BubbleBouncedOffset
                }
                self.destinationView.center = CGPointMake(x, destinationCenter.y)
                }) { (success) -> Void in
                    self.bounceBack(originView: self.destinationView, originLocation: destinationCenter)
            }
            self.bounceBack(originView: self.originView, originLocation: originCenter)
        }
    }
    
    private func bounceBack(#originView: UIView, originLocation: CGPoint) {
        UIView.animateWithDuration(BubbleBounceDuration * 1.6, animations: { () -> Void in
            originView.center = originLocation
            }) { (success) -> Void in
                
        }
    }
}