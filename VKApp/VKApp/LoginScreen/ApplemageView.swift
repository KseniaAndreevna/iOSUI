//
//  AppleImageView.swift
//  VKApp
//
//  Created by Ksusha on 11.03.2021.
//

import UIKit

class ApplemageView: UIView {

    let appleLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSublayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSublayer()
    }
    
    fileprivate func setupSublayer() {
        appleLayer.path = appleImagePath.cgPath
        appleLayer.lineWidth = 3
        appleLayer.strokeColor = UIColor.black.cgColor
        appleLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(appleLayer)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        appleLayer.frame = layer.bounds
    }

}
