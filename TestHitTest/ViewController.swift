//
//  ViewController.swift
//  TestHitTest
//
//  Created by cnwhao@163.com on 2019/12/31.
//  Copyright © 2019 whao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var viewA:ViewA = {
        let view = ViewA()
        view.frame = CGRect(x: 10, y: 80, width: 300, height: 150)
        view.backgroundColor = .red
        return view
    }()
    private lazy var viewB:ViewB = {
        let view = ViewB()
        view.frame = CGRect(x: 30, y: 250, width: 300, height: 150)
        view.backgroundColor = .green
        return view
    }()
    private lazy var viewC:ViewC = {
        let view = ViewC()
        view.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        view.backgroundColor = .blue
        return view
    }()
    private lazy var viewD:ViewD = {
        let view = ViewD()
        view.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        view.backgroundColor = .black
        return view
    }()
    private lazy var viewE:ViewE = {
        let view = ViewE()
        view.frame = CGRect(x: 120, y: 20, width: 100, height: 100)
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var buttonSuperView:UIView = {
        let view = UIView()
        view.frame = CGRect(x: 10, y: 420, width: 160, height: 120)
        view.backgroundColor = .red
        return view
    }()
    private lazy var belowView:UIView = {
        let view = UIView()
        view.frame = CGRect(x: 20, y: 20, width: 120, height: 80)
        view.backgroundColor = .yellow
        return view
    }()
    private lazy var enlargeButton:EnlargeTouchRangeButton = {
        let button = EnlargeTouchRangeButton()
        button.enlargeWidth = 20
        button.enlargeHeight = 20
        button.addTarget(self, action: #selector(enlargeButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 40, y: 40, width: 80, height: 40)
        button.setTitle("button", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var outBoundsView:OutBoundsView = {
        let view = OutBoundsView()
        view.frame = CGRect(x: 100, y: 560, width: 100, height: 100)
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    private lazy var outBoundsButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(outBoundsButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: -20, y: -10, width: 200, height: 160)
        button.backgroundColor = .yellow
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //事件传递、事件响应传递过程。
        setUpHitTestViews()
        //扩大按钮点击范围
        setUpEnlargeButtonViews()
        //超出父视图部分可响应（同理隐藏或完全透明的视图也可以）
        setUpOutBoundsViews()
    }
    
    private func setUpHitTestViews() {
        self.view.addSubview(viewA)
        self.view.addSubview(viewB)
        
        viewA.addSubview(viewC)
        viewB.addSubview(viewD)
        viewB.addSubview(viewE)
    }
    
    private func setUpEnlargeButtonViews() {
        self.view.addSubview(buttonSuperView)
        buttonSuperView.addSubview(belowView)
        buttonSuperView.addSubview(enlargeButton)
    }
    private func setUpOutBoundsViews() {
        self.view.addSubview(outBoundsView)
        outBoundsView.addSubview(outBoundsButton)
    }
    
    @objc private func enlargeButtonTapped() {
        print("enlargeButton>>>>>>>>>>>> 点到我了")
    }
    @objc private func outBoundsButtonTapped() {
        print("outBoundsButton>>>>>>>>>>>> 点到我了")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("=====ViewController touchesBegan")
        // 如果事件传递到此，虽然已经响应了事件，
        //但是下面调用了super，事件会继续向下一个响应者传递，因而一个事件被多个响应者响应。
        super.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("=====ViewController touchesEnded")
        super.touchesEnded(touches, with: event)
    }
}

