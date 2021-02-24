//
//  GroupCell.swift
//  VKApp
//
//  Created by Ksusha on 23.02.2021.
//

import UIKit

class GroupCell: UITableViewCell {

    static let reuseIdentifier = "UserGroupCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainIconImageView: UIImageView!
    //@IBOutlet var openDateLabel: UILabel!
    
    func configure(with group: GroupInfo) {
        nameLabel.text = String(describing: group.name)
        descriptionLabel.text = String(describing: group.description)
        mainIconImageView.image = group.mainPic
        //openDateLabel.text = String(describing: group.openDate
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
