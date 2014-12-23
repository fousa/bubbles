//
//  Bubble.swift
//  Bubbles
//
//  Created by Jelle Vandenbeeck on 23/12/14.
//  Copyright (c) 2014 iCapps. All rights reserved.
//

import UIKit

enum BubbleColor {
    case Blue
    case Yellow
    
    func toColor() -> UIColor {
        switch self {
        case .Blue: return UIColor(red:0.13, green:0.73, blue:0.99, alpha:1)
        case .Yellow: return UIColor(red:1, green:0.74, blue:0.17, alpha:1)
        default: return UIColor.blackColor()
        }
    }
}

class Bubble: UIView {
    
    init(color: BubbleColor) {
        super.init()
        
        self.backgroundColor = color.toColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = frame.size.width / 2.0
    }
}