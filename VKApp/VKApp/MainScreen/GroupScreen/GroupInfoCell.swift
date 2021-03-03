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
    }
    
    func getFormattedDate(date: Date, format: String) -> String {
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: date)
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
