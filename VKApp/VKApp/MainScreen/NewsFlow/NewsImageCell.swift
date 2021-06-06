//
//  NewsImageCell.swift
//  VKApp
//
//  Created by andrey.antropov on 23.05.2021.
//

import UIKit
import SnapKit

class NewsImageCell: UITableViewCell, AnyNewsCell {
    private let newsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsImageView)
        newsImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(200).priority(999)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with news: News) {
        newsImageView.kf.setImage(with: news.url)
    }
}
