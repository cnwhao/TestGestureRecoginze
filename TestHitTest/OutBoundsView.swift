//
//  OutBoundsView.swift
//  TestHitTest
//
//  Created by cnwhao@163.com on 2020/1/4.
//  Copyright © 2020 whao. All rights reserved.
//

import UIKit

class OutBoundsView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("OutBoundsView hitTest>>>>>>>")
        if self.subviews.first?.point(inside: point, with: event) ?? false {
            print("OutBoundsView hitTest<<<<<<< view:\(String(describing: self.subviews.first))")
            return self.subviews.first
        }
        print("OutBoundsView hitTest<<<<<<< view:nil")
        return super.hitTest(point, with: event)
    }
}
