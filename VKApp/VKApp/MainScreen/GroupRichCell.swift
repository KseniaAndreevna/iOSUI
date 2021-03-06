//
//  GroupRichCell.swift
//  VKApp
//
//  Created by Ksusha on 01.03.2021.
//

import UIKit

class GroupRichCell: UITableViewCell {
    
    static let reuseIdentifier = "GroupRichCell"
    static let nibName = "GroupRichCell"
    
    @IBOutlet var groupShadowView: UIView!
    @IBOutlet var groupNameLabel: UILabel!
    //@IBOutlet var dateLabel: UILabel!
    @IBOutlet var groupIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        groupIconImageView.clipsToBounds = true
        groupShadowView.layer.shadowColor = UIColor.systemGreen.cgColor
        groupShadowView.layer.shadowRadius = 4
        groupShadowView.layer.shadowOpacity = 0.8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        groupIconImageView.layer.cornerRadius = groupIconImageView.bounds.width/2
        groupShadowView.layer.cornerRadius = groupShadowView.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with group: Group) {
        groupNameLabel.text = String(describing: group.name)
        //dateLabel.text = String(describing: group.date)
        groupIconImageView.image = group.mainPic
    }
}
