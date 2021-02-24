//
//  FriendCell.swift
//  VKApp
//
//  Created by Ksusha on 21.02.2021.
//

import UIKit

class FriendCell: UITableViewCell {
    
    static let reuseIdentifier = "FriendCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var avatarIconImageView: UIImageView!
    //@IBOutlet var birthdayLabel: UILabel!

    
    func configure(with friend: FriendInfo) {
        nameLabel.text = String(describing: friend.firstName + " " + friend.surname)
        avatarIconImageView.image = friend.avatar
        //birthdayLabel.text = String(describing: friend.birthday)
    }
    
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
