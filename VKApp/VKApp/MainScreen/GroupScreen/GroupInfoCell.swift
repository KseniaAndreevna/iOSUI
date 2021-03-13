//
//  GroupCell.swift
//  VKApp
//
//  Created by Ksusha on 23.02.2021.
//

import UIKit

class GroupInfoCell: UICollectionViewCell {

    static let reuseIdentifier = "GroupInfoCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    func configure(with pic: GroupPic) {
        nameLabel.text = String(describing: pic.name)
        dateLabel.text = getFormattedDate(date: pic.date, format: "dd-MM-yyyy")
        iconImageView.image = pic.pic
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(tapGestureDetected))
        self.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.addTarget(self, action: #selector(swipeGestureDetected))
        self.addGestureRecognizer(swipeGesture)
        
    }
    
    func getFormattedDate(date: Date, format: String) -> String {
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: date)
    }
    
    @objc func tapGestureDetected(_ gesture: UITapGestureRecognizer) {
        animateFriendPic()
        print(#function)
    }
    
    @objc func swipeGestureDetected(_ gesture: UISwipeGestureRecognizer) {
        //сделать цикл по массиву фотографий
        if iconImageView.image == UIImage(named: "panda-go-panda") {
            iconImageView.image = UIImage(named: "pandakopanda")
        } else {
            iconImageView.image = UIImage(named: "panda-go-panda")
        }
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
    
        self.iconImageView.layer.add(animation, forKey: nil)
    }
    
}
