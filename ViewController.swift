//
//  ViewController.swift
//  Reversi
//
//  Created by Hirose.Yudai on 2015/12/15.
//  Copyright © 2015年 Hirose.Yudai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    enum Status {
        case None
        case White
        case Black
    }
    
    enum Direction: Int {
        case Left = -1
        case Up = -8
        case Right = 1
        case Down = 8
        case LeftUp = -9
        case LeftDown = 7
        case RightUp = -7
        case RightDown = 9
        
        static func directions() -> [Direction] {
            return [Left,Up,Right,Down,LeftUp,LeftDown,RightUp,RightDown]
        }
    }
    
    var statuses:[[Status]] = []
    var ban = UIView()
    
    var player: Status = .Black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var array: [Status] = Array(count: 8, repeatedValue: .None)
        for _ in 1...8 {
            statuses.append(array)
        }
        
        let edge = UIScreen.mainScreen().bounds.size.width
        let ban = UIView(frame: CGRectMake(0,100 ,edge,edge))
        self.ban = ban
        
        self.statuses[3][4] = .White
        self.statuses[4][3] = .White
        self.statuses[4][4] = .Black
        self.statuses[3][3] = .Black
        
        var v: CGFloat = 0 , h: CGFloat = 0
        for var _ in 1...8 {
            for var _ in 1...8 {
                let e = edge / 8
                let frame = CGRectMake(v * e , h * e, e, e)
                let button = UIButton(frame: frame)
                button.backgroundColor = self.bgColor(self.statuses[Int(v)][Int(h)])
                button.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
                button.tag = self.p(Int(v), h: Int(h))
                button.layer.borderColor = UIColor.brownColor().CGColor
                button.layer.borderWidth = 1.0
                self.ban.addSubview(button)
                v++
            }
            v = 0
            h++
        }
        
        
        self.view.addSubview(ban)
    }
    
    
    func p(v: Int, h: Int) -> Int {
        return h * 8 + v
    }
    
    func v(p: Int) -> Int {
        return p % 8
    }
    
    func h(p: Int) -> Int {
        return p / 8
    }
    
    func s(p: Int) -> Status {
        return self.statuses[self.v(p)][self.h(p)]
    }
    
    func tapped(button: UIButton) {
        print("p  \(button.tag)")
        print("h : \(h(button.tag))")
        print("v : \(v(button.tag))")
        
        if s(button.tag) != .None {
            return
        }
        
        if can(button.tag).count == 0 {
            return
        }
        
        if self.player == .White {
            self.player = .Black
        } else {
            self.player = .White
        }
        
        button.backgroundColor = self.changedColor(self.player)
        
        
    }
    
    func can(p: Int) -> [Direction] {
        var arr: [Direction] = []
        for direction in Direction.directions() {
            let pos = p + direction.rawValue
            if self.player != self.s(pos) {
                arr.append(direction)
            }
        }
        return arr
    }
    
    
    
    func bgColor(status: Status) -> UIColor {
        switch status {
        case .None: return UIColor.greenColor()
        case .White: return UIColor.whiteColor()
        case .Black: return UIColor.blackColor()
        }
    }
    
    func changedColor(status: Status) -> UIColor {
        switch status {
        case .None :return UIColor.greenColor()
        case .White: return UIColor.blackColor()
        case .Black: return UIColor.whiteColor()
        }
    }

}

