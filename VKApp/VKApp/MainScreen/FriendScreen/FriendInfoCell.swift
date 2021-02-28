//
//  FriendTableViewCell.swift
//  VKApp
//
//  Created by Ksusha on 28.02.2021.
//

import UIKit

class FriendInfoCell: UICollectionViewCell {
    
    static let reuseIdentifier = "FriendInfoCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    func configure(with pic: UserPic) {
        nameLabel.text = String(describing: pic.name)
        dateLabel.text = String(describing: pic.date)
        iconImageView.image = pic.userPic
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
