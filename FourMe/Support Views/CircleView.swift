//
//  CircleView.swift
//  FourMe
//
//  Created by Lars Klassen on 10/26/19.
//  Copyright © 2019 The SilverLogic. All rights reserved.
//

import UIKit

class CircleView: UIControl {

    let outerCircle = CAShapeLayer()
    let fillCircle = CAShapeLayer()
    
    @IBInspectable var color: UIColor?
    @IBInspectable var progressValue: NSNumber?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.addSublayer(outerCircle)
        self.layer.addSublayer(fillCircle)
    }
    
    override func layoutSubviews() {
        let color = self.color ?? UIColor.gray
        self.outerCircle.strokeColor = color.cgColor
        self.outerCircle.fillColor = UIColor.clear.cgColor
        self.outerCircle.lineWidth = 7
        let radius: CGFloat = self.frame.size.width / 2
        self.outerCircle.path = UIBezierPath(roundedRect:
            CGRect(x: 0, y: 0, width: 2.0 * radius, height: 2.0 * radius), cornerRadius: radius).cgPath
        self.outerCircle.strokeEnd = CGFloat(self.progressValue?.floatValue ?? 1.0)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
