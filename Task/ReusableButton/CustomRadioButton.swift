//
//  CustomButton.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//


// TODO: //Move these files to framework

import Foundation
import UIKit

public class CustomRadioButton: UIButton {
    
    fileprivate var circleLayer = CAShapeLayer()
    fileprivate var fillCircleLayer = CAShapeLayer()
    public override var isSelected: Bool {
        didSet {
            toggleButon()
        }
    }
    
    public var circleColor: UIColor = UIColor.red {
        didSet {
            circleLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    public var strokeColor: UIColor = UIColor.gray {
        didSet {
            circleLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    public var circleRadius: CGFloat = 5.0
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    fileprivate func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2*circleRadius, height: 2*circleRadius)
        circleFrame.origin.x = 0 + circleLayer.lineWidth
        circleFrame.origin.y = bounds.height/2 - circleFrame.height/2
        return circleFrame
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    fileprivate func initialize() {
        circleLayer.frame = bounds
        circleLayer.lineWidth = 2
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = strokeColor.cgColor
        layer.addSublayer(circleLayer)
        fillCircleLayer.frame = bounds
        fillCircleLayer.lineWidth = 2
        fillCircleLayer.fillColor = UIColor.clear.cgColor
        fillCircleLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(fillCircleLayer)
        self.toggleButon()
    }
    
    /**
     Toggles selected state of the button.
     */
    func toggleButon() {
        if self.isSelected {
            fillCircleLayer.fillColor = circleColor.cgColor
            circleLayer.strokeColor = circleColor.cgColor
        } else {
            fillCircleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    fileprivate func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: circleFrame())
    }
    
    fileprivate func fillCirclePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: circleFrame().insetBy(dx: 2, dy: 2))
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        circleLayer.frame = bounds
        circleLayer.path = circlePath().cgPath
        fillCircleLayer.frame = bounds
        fillCircleLayer.path = fillCirclePath().cgPath
    }
    
    public override func prepareForInterfaceBuilder() {
        initialize()
    }
}
