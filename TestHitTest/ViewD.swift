//
//  ViewD.swift
//  TestHitTest
//
//  Created by cnwhao@163.com on 2019/12/31.
//  Copyright © 2019 whao. All rights reserved.
//

import UIKit

class ViewD: UIView {
    
   override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("ViewD hitTest>>>>>>>")
        let view = super.hitTest(point, with: event)
        print("ViewD hitTest<<<<<<< view:\(String(describing: view))")
        return super.hitTest(point, with: event)
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("ViewD pointInside>>>>>>>")
        let isInside = super.point(inside: point, with: event)
        print("ViewD pointInside<<<<<<< isInside:\(isInside)")
        return isInside
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(">>>>>>>ViewD touchesBegan")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(">>>>>>>ViewD touchesEnded")
    }
}
