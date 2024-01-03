//
//  CustomTabBar.swift
//  NotesPro
//
//  Created by Timur Baimukhambet on 02.08.2023.
//

import UIKit

@IBDesignable class CustomTabBar: UITabBar {
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 18
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.fillColor = UIColor(red: 19/255, green: 19/255, blue: 19/255, alpha: 1.0).cgColor
        shapeLayer.lineWidth = 0.5
//        shapeLayer.shadowColor = UIColor.red.cgColor
//        shapeLayer.shadowOffset = CGSize(width: 0, height: -2);
//        shapeLayer.shadowOpacity = 0.21
//        shapeLayer.shadowRadius = 8
//        shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(rect: bounds.insetBy(dx: -20, dy: -5))
        return path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        tabFrame.size.height = 65 + (UIApplication.keyWin?.keyWindow?.safeAreaInsets.bottom ?? 100)
        tabFrame.origin.y = self.frame.origin.y + self.frame.height  - 65 - (UIApplication.keyWin?.keyWindow?.safeAreaInsets.bottom ?? 100)
//        self.layer.cornerRadius = 18
        self.frame = tabFrame
        self.items?.forEach({$0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0)})
        
    }

}
