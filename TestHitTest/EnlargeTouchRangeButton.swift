//
//  EnlargeTouchRangeButton.swift
//  TestHitTest
//
//  Created by cnwhao@163.com on 2020/1/4.
//  Copyright © 2020 whao. All rights reserved.
//

import UIKit

class EnlargeTouchRangeButton: UIButton {
    var enlargeWidth:CGFloat = 0
    var enlargeHeight:CGFloat = 0
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if enlargeWidth == 0 && enlargeHeight == 0 {
            return super.point(inside: point, with: event)
        }
        
        var enlargeBounds = bounds
        enlargeBounds.size.width += enlargeWidth
        enlargeBounds.size.height += enlargeHeight
        
        return enlargeBounds.contains(point)
    }
}
