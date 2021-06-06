//
//  PostsRichCell.swift
//  VKApp
//
//  Created by Ksenia Volkova on 09.05.2021.
//

import UIKit

class PostsRichCell: UITableViewCell {
    
    var countLikes: Int = 0
    @IBOutlet var likeButton: UISegmentedControl!
    @IBOutlet var postsHeaderLabel: UILabel!
    @IBOutlet var postsIconImageView: UIImageView!
    @IBOutlet var postsDescriptionText: UITextField!
    
    @IBAction func changeLikeButton(_ sender: Any) {
        if likeButton.selectedSegmentIndex == 1 {
            countLikes = countLikes + 1
        }
        else {
            countLikes = countLikes - 1
        }
        print("PostsRichCell selectedSegmentIndex:\(likeButton.selectedSegmentIndex)")
        print("PostsRichCell countLikes:\(countLikes)")
    }
    
    static let reuseIdentifier = "PostsRichCell"
    static let nibName = "PostsRichCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postsIconImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //postsIconImageView.layer.cornerRadius = (postsIconImageView.bounds.width/2).rounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with posts: Posts) {
        postsHeaderLabel.text = String(describing: posts.header)
        postsHeaderLabel.textColor = UIColor.purple
        postsHeaderLabel.highlightedTextColor = UIColor.red
        postsIconImageView.image = posts.mainPic
        postsDescriptionText.text = posts.description
        postsDescriptionText.textColor = UIColor.darkGray
        postsDescriptionText.accessibilityScroll(UIAccessibilityScrollDirection(rawValue: 4)!)
        print("PostsRichCell \(postsHeaderLabel.text ?? "TEST")")
        //print("PostsRichCell \(likeButton.numberOfSegments)")
        //print("PostsRichCell \(likeButton.selectedSegmentIndex)")
    }
}

