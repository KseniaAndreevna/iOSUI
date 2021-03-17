//
//  CloudImageView.swift
//  VKApp
//
//  Created by Ksusha on 13.03.2021.
//

import UIKit

class CloudImageView: UIView {

    let cloudLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSublayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSublayer()
    }
    
    fileprivate func setupSublayer() {
        cloudLayer.path = cloudImagePath.cgPath
        cloudLayer.lineWidth = 5
        cloudLayer.strokeColor = UIColor.blue.cgColor
        cloudLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(cloudLayer)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        cloudLayer.frame = layer.bounds
    }

}
