//
//  FriendRichCell.swift
//  VKApp
//
//  Created by Ksusha on 03.03.2021.
//

import UIKit
import Kingfisher

class FriendRichCell: UITableViewCell {
    
    static let reuseIdentifier = "FriendRichCell"
    static let nibName = "FriendRichCell"
    
    @IBOutlet var friendShadowView: UIView!
    @IBOutlet var friendNameLabel: UILabel!
    //@IBOutlet var dateLabel: UILabel!
    @IBOutlet var friendIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        friendIconImageView.clipsToBounds = true
        friendShadowView.layer.shadowColor = UIColor.systemBlue.cgColor
        friendShadowView.layer.shadowRadius = 4
        friendShadowView.layer.shadowOpacity = 0.8
        
        //        let tapGesture = UITapGestureRecognizer()
        //        tapGesture.addTarget(self, action: #selector(tapGestureDetected))
        //        self.friendIconImageView.addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        friendIconImageView.layer.cornerRadius = friendIconImageView.bounds.width/2
        friendShadowView.layer.cornerRadius = friendShadowView.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    } 
    
    public func configure(with friend: User) {
        friendNameLabel.text = "\(friend.firstName) \(friend.lastName)"
//        //dateLabel.text = String(describing: friend.date)
//        friendIconImageView.image =  friend.avatar
        //friendIconImageView.kf.setImage(with: friend.photoUrl)
    }
    
    @objc func tapGestureDetected(_ gesture: UITapGestureRecognizer) {
        //animateFriendPic()
        print(#function)
    }

    func animateFriendPic() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.friendIconImageView.layer.add(animation, forKey: nil)
    }
    
}
