//
//  XLTabBar.swift
//  tabbar demo
//
//  Created by holdtime on 2017/7/31.
//  Copyright © 2017年 www.bthdtm.com 豪德天沐移动事业部. All rights reserved.
//

import UIKit

class XLTabBarButton:UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 49, width: 49, height: 49/2.0)
    }
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(origin: .zero, size: CGSize(width: 49, height: 49))
    }
}

class XLTabBar: UITabBar {
    
    let menuButton = XLTabBarButton(type: .custom)

    override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        
        guard var xlitems = items,xlitems.count%2 == 1 else {
            return super.setItems(items, animated: animated)
        }
        
        if self.frame.origin != .zero {
            
            menuButton.frame = CGRect(origin: .zero, size: CGSize(width: 49, height: 49*(3/2.0)))
            menuButton.center = CGPoint(x: self.center.x, y: 49/4.0)
            self.addSubview(menuButton)
            
            let itemcenter = xlitems[xlitems.count/2]
            
            menuButton.setTitle(itemcenter.title, for: .normal)
            menuButton.setImage(itemcenter.image, for: .normal)

            itemcenter.title = nil
            itemcenter.image = nil
            
            menuButton.setTitleColor(self.tintColor, for: .normal)
            menuButton.addTarget(self, action:#selector(self.tabBar(_:didSelect:)), for: .touchUpInside)
            
            xlitems[xlitems.count/2] = itemcenter
            
            super.setItems(xlitems, animated: animated)
        }
  
    }
    
    open func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        print("click")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.width/2-(49/2.0), y: 0))
        path.addArc(withCenter: CGPoint(x: rect.width/2, y: 0), radius: 49/2.0, startAngle: -CGFloat.pi, endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: rect.width, y: 0))

        let lineShadow = CAShapeLayer()
        lineShadow.path = path.cgPath
        lineShadow.lineWidth = 0.5
        lineShadow.fillColor = UIColor.clear.cgColor
        lineShadow.strokeColor = UIColor.white.cgColor
        
        lineShadow.shadowColor = UIColor.black.cgColor
        lineShadow.shadowRadius = 0.5
        lineShadow.shadowOpacity = 0.8
        lineShadow.shadowOffset = CGSize(width: 0, height: -0.5)
        
        self.layer.addSublayer(lineShadow)

    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        var view:UIView?
        for sview in self.subviews {
            let testPoint = sview.convert(point, from: self)
            if sview.bounds.contains(testPoint) {
                if sview.bounds.contains(self.menuButton.bounds){
                    view = sview
                    return view
                }
                view = sview
            }
        }
        if view == nil {
            view = super.hitTest(point, with: event)
        }
        return view
    }

}

class XLTabBarControoler:UITabBarController {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        guard item.title == "Hello" else {
           
            return
        }
        let tab = tabBar as! XLTabBar
        tab.tabBar(tabBar, didSelect: item)
       
    }
    
    
}
