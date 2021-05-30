//
//  NewsTextCell.swift
//  VKApp
//
//  Created by andrey.antropov on 23.05.2021.
//

import UIKit
import SnapKit

class NewsTextCell: UITableViewCell, AnyNewsCell {
    private let newsTextLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsTextLabel)
        newsTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with news: News) {
        newsTextLabel.text = news.name
    }
}
