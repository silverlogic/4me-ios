//
//  CircleView.swift
//  FourMe
//
//  Created by Lars Klassen on 10/26/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit

class CircleView: UIView {

    let outerCircle = CAShapeLayer()
    let fillCircle = CAShapeLayer()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.addSublayer(outerCircle)
        self.layer.addSublayer(fillCircle)
    }
    
    override func layoutSubviews() {
        self.outerCircle.strokeColor = UIColor.gray.cgColor
        self.outerCircle.fillColor = UIColor.clear.cgColor
        self.outerCircle.lineWidth = 4
        let radius: CGFloat = self.frame.size.width / 2
        self.outerCircle.path = UIBezierPath(roundedRect:
            CGRect(x: 0, y: 0, width: 2.0 * radius, height: 2.0 * radius), cornerRadius: radius).cgPath
        self.outerCircle.strokeEnd = 0.8
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
