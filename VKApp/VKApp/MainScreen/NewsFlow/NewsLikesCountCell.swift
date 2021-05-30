//
//  NewsLikesCountCell.swift
//  VKApp
//
//  Created by andrey.antropov on 23.05.2021.
//

import UIKit

class NewsLikesCountCell: UITableViewCell, AnyNewsCell {
    private let likeImageView = UIImageView()
    private let likesCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with news: News) {
        
    }
}
