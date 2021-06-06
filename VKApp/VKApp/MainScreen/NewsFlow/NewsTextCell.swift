//
//  NewsTextCell.swift
//  VKApp
//
//  Created by andrey.antropov on 23.05.2021.
//

import UIKit
import SnapKit

class NewsTextCell: UITableViewCell, AnyNewsCell {
    
    static let horizontalInset: CGFloat = 12
    static let verticalInset: CGFloat = 8
    
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
        newsTextLabel.text = news.text
        newsTextLabel.numberOfLines = 0
        newsTextLabel.contentMode = .scaleToFill
        newsTextLabel.font = UIFont.systemFont(ofSize: 14)//font
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsTextLabel.text = nil//""
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTextLabel.frame = contentView.bounds.insetBy(dx: NewsRichCell.horizontalInset, dy: NewsRichCell.verticalInset)
    }
    
}
