//
//  NewsSourceCell.swift
//  VKApp
//
//  Created by andrey.antropov on 23.05.2021.
//

import UIKit
import SnapKit

class NewsSourceCell: UITableViewCell, AnyNewsCell {
    private let avatarImageView = UIImageView()
    private let authorName = UILabel()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(authorName)
        contentView.addSubview(dateLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.width.equalTo(avatarImageView.snp.height)
            make.width.equalTo(50).priority(999)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(12)
        }
        
        authorName.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatarImageView.image = nil
        self.authorName.text = nil
        self.dateLabel.text = nil
    }
    
    
    public func configure(with news: News) {
//        if let newsSource = news.source {
//            avatarImageView.kf.setImage(with: newsSource.imageUrl)
//            authorName.text = newsSource.name
//        } else {
//            avatarImageView.image = UIImage(named: "panda01")
//            authorName.text = "Панда Пандович"
//        }
        
        let newsSource = news.source
        if news.sourceId < 0 {
            guard let group = try? RealmService.get(type: Group.self).filter("groupId == %@", -news.sourceId).first else { return }
            authorName.text = group.name
            avatarImageView.kf.setImage(with: newsSource?.imageUrl)
        } else {
            guard let user = try? RealmService.get(type: User.self).filter("id == %@", news.sourceId).first else { return }
            authorName.text = "\(user.firstName) \(user.lastName)"
            avatarImageView.kf.setImage(with: newsSource?.imageUrl)
        }

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        self.dateLabel.text = dateFormatter.string(from: news.date)

    }
}
