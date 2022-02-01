//
//  Extensions.swift
//  CoolInstagram
//
//  Created by Vincent Moyo on 2022/02/01.
//

import Foundation
import UIKit

extension UIView {
    
    public var width: CGFloat {
        frame.size.width
    }
    
    public var height: CGFloat {
        frame.size.height
    }
    
    public var top: CGFloat {
        frame.origin.y
    }
    
    public var bottom: CGFloat {
        frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        frame.origin.x
    }
    
    public var right: CGFloat {
        frame.origin.x + frame.size.width
    }
}
