//
//  RingView.swift
//  ActivityPlusTwo
//
//  Created by NSScreencast on 5/31/16.
//  Copyright © 2016 NSScreencast. All rights reserved.
//

import UIKit

class RingBackgroundView : UIView {
    var color: UIColor = UIColor.brownColor()
    
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
        shapeLayer.fillColor = color.CGColor
    }
}

class RingView : UIView {
    
    var rings = [String: CAShapeLayer]()
    
    var backgroundView: RingBackgroundView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundView = RingBackgroundView(frame: bounds)
        addSubview(backgroundView)
        
        self.backgroundColor = UIColor.clearColor()
    }

    func addRing(identifier: String, radius: CGFloat, color: UIColor, amount: CGFloat, strokeWidth: CGFloat) {
        
        let ringLayer = CAShapeLayer()
        let center = CGPointMake(CGRectGetWidth(bounds)/2, CGRectGetHeight(bounds)/2)
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = CGFloat(3 * M_PI_2)
        ringLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
        
        ringLayer.strokeStart = 0
        ringLayer.strokeEnd = amount
        ringLayer.strokeColor = color.CGColor
        ringLayer.lineWidth = strokeWidth
        ringLayer.lineCap = kCALineCapButt
        ringLayer.fillColor = UIColor.clearColor().CGColor
        
        layer.addSublayer(ringLayer)
        
        rings[identifier] = ringLayer
    }
    
    func setAmount(amount: CGFloat, forRingIdentifier identifier: String) {
        rings[identifier]?.strokeEnd = amount
    }
}
