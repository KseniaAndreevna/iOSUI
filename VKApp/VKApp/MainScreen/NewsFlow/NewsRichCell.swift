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
    
    static let horizontalInset: CGFloat = 12
    static let verticalInset: CGFloat = 8
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsIconImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsNameLabel.frame = contentView.bounds.insetBy(dx: NewsRichCell.horizontalInset, dy: NewsRichCell.verticalInset)
        //newsIconImageView.layer.cornerRadius = (newsIconImageView.bounds.width/2).rounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with news: News) {
        newsNameLabel.text = news.text
//        newsIconImageView.image = news.mainPic
        print("NewsRichCell \(newsNameLabel.text ?? "TEST")")
        //print("NewsRichCell \(likeButton.numberOfSegments)")
        //print("NewsRichCell \(likeButton.selectedSegmentIndex)")
    }
    
    func configure(with news: News, font: UIFont) {
        newsNameLabel.text = news.text
        newsNameLabel.numberOfLines = 0
        newsNameLabel.contentMode = .scaleToFill
        newsNameLabel.font = font
    }
    
    override func prepareForReuse() {
        newsNameLabel.text = nil
    }
    
}
