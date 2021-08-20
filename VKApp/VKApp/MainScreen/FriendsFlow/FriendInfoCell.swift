//
//  FriendTableViewCell.swift
//  VKApp
//
//  Created by Ksusha on 28.02.2021.
//

import UIKit
import Kingfisher

class FriendInfoCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FriendInfoCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var tapCounter: UILabel!
    var tapCount: Int = 0
    
//    func configure(with pic: UserPic) {
//        nameLabel.text = String(describing: pic.name)
//        dateLabel.text = String(describing: pic.date)
//        iconImageView.image = pic.userPic
//        tapCounter.text = String(tapCount)
//
//        let tapGesture = UITapGestureRecognizer()
//        tapGesture.addTarget(self, action: #selector(tapGestureDetected))
//        self.addGestureRecognizer(tapGesture)
//    }
    
    func configure(with pic: VKPhoto) {
        nameLabel.text = "ID: " + String(describing: pic.id)
        dateLabel.text = "Дата: " + String(describing: Date())
        iconImageView.kf.setImage(with: pic.sizes.last?.photoUrl) //first
        tapCounter.text = String(tapCount)
        
        nameLabel.backgroundColor = .white
        dateLabel.backgroundColor = .white
        iconImageView.backgroundColor = .white
        tapCounter.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(tapGestureDetected))
        self.addGestureRecognizer(tapGesture)
    }
   
   
    @objc func tapGestureDetected(_ gesture: UITapGestureRecognizer) {
        animateFriendPic()
        animateCounter()
    }

    func animateFriendPic() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.3
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.iconImageView.layer.add(animation, forKey: nil)
        //if LikeView().isLiked { tapCount += 1 }
    }
    
    func animateCounter() {
        tapCount += 1
        tapCounter.text = String(tapCount)

        UIView.transition(with: self.tapCounter, duration: 0.3, options: [.transitionCrossDissolve]) { [self] in
            self.tapCounter.text = String(tapCount) } completion: { _ in }
        
        //if LikeView().isLiked { tapCount += 1 }
    }
    
//    func configure(with friend: Friend) {
//        nameLabel.text = String(describing: friend.firstName + " " + friend.surname)
//        dateLabel.text = String(describing: Date())
//        iconImageView.image = friend.avatar
//    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
