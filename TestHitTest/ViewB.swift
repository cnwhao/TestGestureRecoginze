//
//  ViewB.swift
//  TestHitTest
//
//  Created by cnwhao@163.com on 2019/12/31.
//  Copyright © 2019 whao. All rights reserved.
//

import UIKit

class ViewB: UIView {
    private var isInside:Bool = false
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("ViewB hitTest>>>>>>>")
        let view = super.hitTest(point, with: event)
        print("ViewB hitTest<<<<<<< view:\(String(describing: view))")
        if isInside == true {
            //如果self 则传递终止
            isInside = false
            return self
        }
        return super.hitTest(point, with: event)
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("ViewB pointInside>>>>>>>")
        isInside = super.point(inside: point, with: event)
        print("ViewB pointInside<<<<<<< isInside:\(isInside)")
        return isInside
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(">>>>>>>ViewB touchesBegan")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(">>>>>>>ViewB touchesEnded")
    }
}
