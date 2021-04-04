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
    @IBInspectable var lineWidth: CGFloat = 3
    let heartLayer = CAShapeLayer()
        
    public var isLiked: Bool = false { didSet { setNeedsDisplay() } }
    var heartColor: UIColor { return isLiked ? .red : .clear }
    var strokeColor: UIColor { return isLiked ? .clear : .black }

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSublayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSublayer()
    }
    
    fileprivate func setupSublayer() {
        heartLayer.path = heartImagePath.cgPath
        heartLayer.lineWidth = 3
        //heartLayer.strokeColor = UIColor.black.cgColor
        //heartLayer.fillColor = UIColor.white.cgColor
        heartLayer.strokeColor = strokeColor.cgColor
        heartLayer.fillColor = heartColor.cgColor
        heartLayer.lineJoin = CAShapeLayerLineJoin.round
        layer.addSublayer(heartLayer)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        heartLayer.frame = layer.bounds
    }
    
    override func draw(_ rect: CGRect) {
        //guard let context = UIGraphicsGetCurrentContext() else { return }
        let context = UIGraphicsGetCurrentContext()!
        //context.saveGState()

        let path = heartImagePath//UIBezierPath()
        
        //треугольник
//        let insettedRect = rect.inset(by: UIEdgeInsets(top: sideWidth, left: sideWidth, bottom:sideWidth, right: sideWidth))
//        path.move(to: CGPoint(x: sideWidth, y: sideWidth))
//        path.addLine(to: CGPoint(x: insettedRect.maxX, y: insettedRect.midY))
//        path.addLine(to: CGPoint(x: sideWidth, y: insettedRect.maxY))
//        path.close()
        
        //первый вариант
//        let sideOne = sideWidth * 0.4
//        let sideTwo = sideWidth * 0.3
//        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
//        path.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: CGFloat(deg2rad(135)), endAngle: CGFloat(deg2rad(315)), clockwise: true)
//        path.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
//        path.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: CGFloat(deg2rad(225)), endAngle: CGFloat(deg2rad(45)), clockwise: true)
//        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
//        path.close()
        
        //второй вариант
//        let topArcsRadius = sideWidth/4
//        path.move(to: CGPoint(x: sideWidth/2, y: sideWidth))
//        path.addLine(to: CGPoint(x: 0, y: topArcsRadius))
//        path.addArc(withCenter: CGPoint(x: topArcsRadius, y: topArcsRadius),
//        radius: topArcsRadius, startAngle: .pi, endAngle: .pi*2, clockwise: true)
//        path.addArc(withCenter: CGPoint(x: 3*topArcsRadius, y: topArcsRadius),
//        radius: topArcsRadius, startAngle: .pi, endAngle: .pi*2, clockwise: true)
//        path.close()
        
        //context.setStrokeColor(UIColor.black.cgColor)
        //context.setFillColor(UIColor.red.cgColor)
        //context.addPath(path.cgPath)
        //context.strokePath()
        
        context.setFillColor(heartColor.cgColor)
        context.addPath(path.cgPath) //heartImagePath.cgPath
        context.fillPath()
        
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineJoin(CGLineJoin.round)
        context.setLineWidth(lineWidth)
        context.addPath(path.cgPath)
        context.strokePath()

        //context.restoreGState()
    }
    
    @objc func pinchGestureDetected(_ gesture: UIPinchGestureRecognizer) {
        print(gesture.scale)
    }
    
    @objc func tapGestureDetected(_ gesture: UITapGestureRecognizer) {
        isLiked.toggle()
        sendActions(for: UIControl.Event.valueChanged)
        print(#function)
        
        //animateFriendPic()
        //animateCounter()
        
//        if isLiked {
//            transform = CGAffineTransform(rotationAngle: .pi).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
//        } else {
//            transform = .identity
//        }
    }
}

//Heart Image
let heartImagePath: UIBezierPath = {
    let path = UIBezierPath()
    let sideWidth: CGFloat = 40
    let topArcsRadius = sideWidth/4
    path.move(to: CGPoint(x: sideWidth/2, y: sideWidth))
    path.addLine(to: CGPoint(x: 0, y: topArcsRadius))
    path.addArc(withCenter: CGPoint(x: topArcsRadius, y: topArcsRadius),
    radius: topArcsRadius, startAngle: .pi, endAngle: .pi*2, clockwise: true)
    path.addArc(withCenter: CGPoint(x: 3*topArcsRadius, y: topArcsRadius),
    radius: topArcsRadius, startAngle: .pi, endAngle: .pi*2, clockwise: true)
    path.close()
    return path
}()
