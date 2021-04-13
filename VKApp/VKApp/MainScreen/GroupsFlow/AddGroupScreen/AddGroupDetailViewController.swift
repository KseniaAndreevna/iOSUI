//
//  AddGroupDetailViewController.swift
//  VKApp
//
//  Created by Ksenia Volkova on 18.03.2021.
//

import UIKit

class AddGroupDetailViewController: UIViewController {
    
    private let images = [
        generatePhoto(),
        generatePhoto(),
        generatePhoto(),
        generatePhoto(),
    ]

    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var forthImageView: UIImageView!
    //@IBOutlet var seeMoreView: UIView!
    
    private var imageViews: [UIImageView] {
        [
            firstImageView,
            secondImageView,
            thirdImageView,
            forthImageView,
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        seeMoreView.isHidden = false
        
        for (possiblePhoto, imageView) in zip(images, imageViews) {
            if let photo = possiblePhoto {
                imageView.image = photo
            } else {
                imageView.image = nil
                imageView.isHidden = true
                //seeMoreView.isHidden = true
            }
        }
        
//        if images.compactMap { $0 }.count == images.count {
//            seeMoreView.isHidden = false
//        } else {
//            seeMoreView.isHidden = true
//        }
        
    }
}

private func generatePhoto() -> UIImage? {
    if Bool.random() {
        return groupImages.randomElement()
    } else {
        return nil
    }
}

let groupImages = [
    UIImage(named: "panda01")!,
    UIImage(named: "panda02")!,
    UIImage(named: "panda03")!,
    UIImage(named: "panda04")!,
    UIImage(named: "panda05")!,
]
