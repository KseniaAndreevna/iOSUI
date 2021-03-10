//
//  LikeView.swift
//  VKApp
//
//  Created by Ksusha on 01.03.2021.
//

import UIKit

//@IBDesignable
class LikeView: UIControl {

    @IBOutlet var likeImageView: UIImageView!
    @IBInspectable var lineWidth: CGFloat = 50
        
    public var isLiked: Bool = false { didSet { setNeedsDisplay() } }
    var heartColor: UIColor { return isLiked ? .red : .black }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeImageView.image = UIImage(named: "bears")
        likeImageView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(tapGestureDetected))
        self.addGestureRecognizer(tapGesture)
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        
        //Calculate Radius of Arcs using Pythagoras
        //let sideOne = lineWidth * 0.4
        //let sideTwo = lineWidth * 0.3
        //let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
        
        //let insettedRect = rect.inset(by: UIEdgeInsets(top: lineWidth, left: lineWidth, bottom:lineWidth, right: lineWidth))
        
        let path = UIBezierPath()
        
        //треугольник
//        path.move(to: CGPoint(x: lineWidth, y: lineWidth))
//        path.addLine(to: CGPoint(x: insettedRect.maxX, y: insettedRect.midY))
//        path.addLine(to: CGPoint(x: lineWidth, y: insettedRect.maxY))
//        path.close()
        
        //первый вариант
//        path.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: CGFloat(deg2rad(135)), endAngle: CGFloat(deg2rad(315)), clockwise: true)
//        path.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
//        path.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: CGFloat(deg2rad(225)), endAngle: CGFloat(deg2rad(45)), clockwise: true)
//        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
//        path.close()
        
        //второй вариант
//        path.move(to: CGPoint(x: rect.midX, y: rect.maxY ))
//        path.addCurve(to: CGPoint(x: rect.minX, y: rect.height/4),
//                      controlPoint1: CGPoint(x: rect.midX, y: rect.height*3/4) ,
//                      controlPoint2: CGPoint(x: rect.minX, y: rect.midY) )
//        path.addArc(withCenter: CGPoint( x: rect.width/4,y: rect.height/4),
//              radius: (rect.width/4),
//              startAngle: CGFloat(deg2rad(Double.pi)), //Angle(radians: Double.pi),
//              endAngle: CGFloat(deg2rad(0)), //Angle(radians: 0),
//              clockwise: false)
//        path.addArc(withCenter: CGPoint( x: rect.width * 3/4,y: rect.height/4),
//              radius: (rect.width/4),
//              startAngle: CGFloat(deg2rad(Double.pi)), //Angle(radians: Double.pi),
//              endAngle: CGFloat(deg2rad(0)), //Angle(radians: 0),
//              clockwise: false)
//        path.addCurve(to: CGPoint(x: rect.midX, y: rect.height),
//                      controlPoint1: CGPoint(x: rect.width, y: rect.midY),
//                      controlPoint2: CGPoint(x: rect.midX, y: rect.height*3/4) )
//
//        path.close()
        //
        
        //третий вариант
        //print(rect.width)
        let topArcsRadius = lineWidth/4
        path.move(to: CGPoint(x: lineWidth/2, y: lineWidth))
        path.addLine(to: CGPoint(x: 0, y: topArcsRadius))
        path.addArc(withCenter: CGPoint(x: topArcsRadius, y: topArcsRadius),
        radius: topArcsRadius, startAngle: .pi, endAngle: .pi*2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: 3*topArcsRadius, y: topArcsRadius),
        radius: topArcsRadius, startAngle: .pi, endAngle: .pi*2, clockwise: true)
        path.close()
        
        //
        //context.setStrokeColor(UIColor.black.cgColor)
        context.setStrokeColor(heartColor.cgColor)
        //context.setFillColor(heartColor.cgColor)
        context.addPath(path.cgPath)
        context.setLineWidth(lineWidth)
        context.strokePath()
        
        context.setFillColor(UIColor.white.cgColor)
        context.addPath(path.cgPath)
        context.fillPath()
        
        context.restoreGState()
    }
    
    @objc func pinchGestureDetected(_ gesture: UIPinchGestureRecognizer) {
        print(gesture.scale)
    }
    
    @objc func tapGestureDetected(_ gesture: UITapGestureRecognizer) {
        isLiked.toggle()
        sendActions(for: UIControl.Event.valueChanged)
        
//        if isLiked {
//            transform = CGAffineTransform(rotationAngle: .pi).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
//        } else {
//            transform = .identity
//        }
    }
}
