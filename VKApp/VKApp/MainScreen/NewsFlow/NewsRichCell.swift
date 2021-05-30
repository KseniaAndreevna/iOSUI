//
//  NewsRichCell.swift
//  VKApp
//
//  Created by Ksusha on 03.03.2021.
//

import UIKit

class NewsRichCell: UITableViewCell {
    
    var countLikes: Int = 0
    @IBOutlet var likeButton: UISegmentedControl!
    @IBOutlet var newsNameLabel: UILabel!
    @IBOutlet var newsIconImageView: UIImageView!
    
    @IBAction func changeLikeButton(_ sender: Any) {
        if likeButton.selectedSegmentIndex == 1 {
            countLikes = countLikes + 1
        }
        else {
            countLikes = countLikes - 1
        }
        print("NewsRichCell selectedSegmentIndex:\(likeButton.selectedSegmentIndex)")
        print("NewsRichCell countLikes:\(countLikes)")
    }
    
    static let reuseIdentifier = "NewsRichCell"
    static let nibName = "NewsRichCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsIconImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //newsIconImageView.layer.cornerRadius = newsIconImageView.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with news: News) {
        newsNameLabel.text = String(describing: news.name)
//        newsIconImageView.image = news.mainPic
        print("NewsRichCell \(newsNameLabel.text ?? "TEST")")
        //print("NewsRichCell \(likeButton.numberOfSegments)")
        //print("NewsRichCell \(likeButton.selectedSegmentIndex)")
    }
}
