//
//  FriendImagesViewController.swift
//  VKApp
//
//  Created by Ksenia Volkova on 19.03.2021.
//

import UIKit

class FriendImagesViewController: UIViewController {
    
    @IBOutlet var currentImageView: UIImageView!
    @IBOutlet var nextAppearingImageView: UIImageView!
    
    private var displayedImages: [UIImage] = [
        UIImage(named: "panda01")!,
        UIImage(named: "panda02")!,
        UIImage(named: "panda03")!,
        UIImage(named: "panda04")!,
    ]
    
    private var currentPhotoIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func imageSwipedRight(_ sender: UISwipeGestureRecognizer) {
        print(#function)
        guard currentPhotoIndex > 0 else { return }
        
        let newPhotoIndex = currentPhotoIndex - 1
        let newPhoto = displayedImages[newPhotoIndex]
        
        nextAppearingImageView.image = newPhoto
        nextAppearingImageView.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 200)
        
        UIView.animate(withDuration: 1) { [self] in
            currentImageView.transform = CGAffineTransform(translationX: self.view.bounds.width, y: -100)
            nextAppearingImageView.transform = .identity
        } completion: { [self] _ in
            currentImageView.image = newPhoto
            currentImageView.transform = .identity
            nextAppearingImageView.transform = .identity
            currentPhotoIndex = newPhotoIndex
        }
    }
    
    @IBAction func imageSwipedLeft(_ sender: UISwipeGestureRecognizer) {
        print(#function)
        guard currentPhotoIndex < displayedImages.count - 1 else { return }
        
        let newPhotoIndex = currentPhotoIndex + 1
        let newPhoto = displayedImages[newPhotoIndex]
        
        nextAppearingImageView.image = newPhoto
        nextAppearingImageView.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 200)
        
        UIView.animate(withDuration: 1) { [self] in
            currentImageView.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: -100)
            nextAppearingImageView.transform = .identity
        } completion: { [self] _ in
            currentImageView.image = newPhoto
            currentImageView.transform = .identity
            nextAppearingImageView.transform = .identity
            currentPhotoIndex = newPhotoIndex
        }
    }
}
