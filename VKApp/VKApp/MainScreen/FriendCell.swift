//
//  UserTableViewCell.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet var friendLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var avatarIconImageView: UIImageView!
    
    static let reuseIdentifier = "FriendCell"
        
    func configure(with friend: Friend) {
        friendLabel.text = String(describing: friend.firstName + " " + friend.surname)
        //avatarIconImageView.image = friend.avatar
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
