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
        dateLabel.text = String(describing: pic.date)
        iconImageView.image = pic.groupPic
    }
    
//
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
