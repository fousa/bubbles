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
        case .Blue: return UIColor.blueColor()
        case .Yellow: return UIColor.yellowColor()
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
}