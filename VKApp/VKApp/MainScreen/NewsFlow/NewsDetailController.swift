//
//  NewsDetailController.swift
//  VKApp
//
//  Created by Ksusha on 13.03.2021.
//

import UIKit

class NewsDetailController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet var mainView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    private let panGesture = UIPanGestureRecognizer()
    private let swipeDownGesture = UISwipeGestureRecognizer()
    private let swipeUpGesture = UISwipeGestureRecognizer()
    private let swipeLeftGesture = UISwipeGestureRecognizer()
    private let swipeRightGesture = UISwipeGestureRecognizer()
    
    private func generatePhoto() -> UIImage? {
        return pandaImages.randomElement()
    }

    let pandaImages = [
        UIImage(named: "panda01")!,
        UIImage(named: "panda02")!,
        UIImage(named: "panda03")!,
        UIImage(named: "panda04")!,
        UIImage(named: "panda05")!,
        UIImage(named: "panda06")!,
        UIImage(named: "panda07")!,
        UIImage(named: "panda08")!,
        UIImage(named: "panda09")!,
        UIImage(named: "panda10")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (imageView, photo) in zip(imageViews, pandaImages) {
            imageView.image = photo
        }
        
        let edgeGesture: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action:#selector(self.handleTopEdgeGesture(_:)))
        edgeGesture.edges = UIRectEdge.top
        edgeGesture.delegate = self
        self.mainView!.addGestureRecognizer(edgeGesture)
        
//        let edgeGesture = UITapGestureRecognizer(target: self, action: #selector(handleTopEdgeGesture))
//        scrollView?.addGestureRecognizer(edgeGesture)
    
        swipeDownGesture.addTarget(self, action: #selector(swipeDownGestureDetected(_:)))
        self.mainView.addGestureRecognizer(swipeDownGesture)
        swipeDownGesture.delegate = self
    }
    
    @objc func handleTopEdgeGesture(_ gesture:UIScreenEdgePanGestureRecognizer) {
        print(#function)
    }
    
    @objc func swipeDownGestureDetected(_ gesture: UISwipeGestureRecognizer) {
        print(#function)
    }

}
