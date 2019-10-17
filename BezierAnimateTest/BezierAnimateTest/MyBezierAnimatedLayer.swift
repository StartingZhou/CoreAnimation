//
//  MyBezierAnimatedLayer.swift
//  BezierAnimateTest
//
//  Created by developer on 2019/10/17.
//  Copyright © 2019 Nextop. All rights reserved.
//

import UIKit

class MyBezierAnimatedLayer: CALayer {
    private var _bezierMinSpace: CGFloat = 20
    private var _resistHeight: CGFloat = 0
    
    private var _lineWidth: CGFloat = 0
    var lineWidth: CGFloat {
        set {
            _lineWidth = newValue
            self.setNeedsDisplay()
        }
        
        get {
            return _lineWidth
        }
    }
    
    private var _strokeColor: CGColor = UIColor.lightGray.cgColor
    var strokeColor: CGColor {
        set {
            _strokeColor = newValue
            self.setNeedsDisplay()
        }
        
        get {
            return _strokeColor
        }
    }
    
    private var _backColor: CGColor = UIColor.gray.cgColor
    var backColor: CGColor {
        set {
            _backColor = newValue
            self.setNeedsDisplay()
        }
        
        get {
            return _backColor
        }
    }
    
    private var _contentHeight: CGFloat = 0
    var contentHeight: CGFloat {
        set {
            if newValue < 0 {
                _contentHeight = 0
            } else {
                _contentHeight = newValue
            }
            self.setNeedsDisplay()
        }
        get {
            return _contentHeight
        }
    }
    
    private var _originHeight: CGFloat = 0
    override var frame: CGRect {
        set {
            let heightValidate = newValue.height < 0 ? 0 : newValue.height
            super.frame = CGRect.init(x: newValue.origin.x, y: newValue.origin.y, width: newValue.width, height: heightValidate)
            _originHeight = heightValidate
            _contentHeight = heightValidate
        }
        
        get {
            return super.frame
        }
    }
    
    var horizontalSpace: CGFloat = 50 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    init(radius: CGFloat,
         resistHeight: CGFloat = 0,
         strokeColor: UIColor = UIColor.lightGray,
         backgroundColor: UIColor = UIColor.gray) {
        self._resistHeight = resistHeight
        self._bezierMinSpace = radius
        self._strokeColor = strokeColor.cgColor
        self._backColor = backgroundColor.cgColor
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func display() {
        let width = self.bounds.width
        let height = self.contentHeight < _resistHeight ? _resistHeight: self.contentHeight
        let originX: CGFloat = 0.0
        let originY: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: self.bounds.width, height: height), false, 0)
        let context = UIGraphicsGetCurrentContext()
        let path: CGMutablePath = CGMutablePath.init()
        path.move(to: CGPoint.init(x: originX, y: originY))
        path.addLine(to: CGPoint.init(x: width, y: originY))
        let curveY = height - _bezierMinSpace * height / _originHeight > _resistHeight ? height - _bezierMinSpace * height / _originHeight :_resistHeight
        path.addLine(to: CGPoint.init(x: width, y: curveY))
        path.addQuadCurve(to: CGPoint.init(x: width / 2, y: height), control: CGPoint.init(x: width - horizontalSpace, y: height))
        path.addQuadCurve(to: CGPoint.init(x: 0, y: curveY), control: CGPoint.init(x: horizontalSpace, y: height))
        path.closeSubpath()
        context?.setStrokeColor(self.strokeColor)
        context?.setFillColor(self.backColor)
        context?.setLineWidth(self.lineWidth)
        context?.addPath(path)
        context?.drawPath(using: CGPathDrawingMode.fillStroke)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.contentsScale = UIScreen.main.scale
        self.contents = image?.cgImage
        self.contentsGravity = CALayerContentsGravity.bottomLeft
    }
}
