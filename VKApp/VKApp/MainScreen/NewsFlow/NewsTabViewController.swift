//
//  NewsTabViewController.swift
//  VKApp
//
//  Created by Ksusha on 06.03.2021.
//

import UIKit

protocol AnyNewsCell {
    
}

enum NewsType: CaseIterable {
    case source
    case image
    case text
    case likes
    
//    func associatedCellClass<T: AnyNewsCell>() -> T.Type {
//        switch self {
//        case .image:
//            return NewsImageCell.self
//        case .likes:
//            return NewsLikesCountCell.self
//        case .source:
//            return NewsSourceCell.self
//        case .text:
//            return NewsTextCell.self
//        }
//    }
    
    var associatedCellIdentifier: String {
        switch self {
        case .image:
            return "NewsImageCell"
        case .likes:
            return "NewsLikesCountCell"
        case .source:
            return "NewsSourceCell"
        case .text:
            return "NewsTextCell"
        }
    }
}

class NewsTabViewController: UITableViewController {

    private(set) var news: [News] = []
    
    let networkingService = NetworkService(token: Session.shared.token)
                
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: NewsRichCell.nibName, bundle: nil), forCellReuseIdentifier: NewsRichCell.reuseIdentifier)
        
        tableView.register(NewsImageCell.self, forCellReuseIdentifier: "NewsImageCell")
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: "NewsTextCell")
        tableView.register(NewsSourceCell.self, forCellReuseIdentifier: "NewsSourceCell")
        tableView.register(NewsLikesCountCell.self, forCellReuseIdentifier: "NewsLikesCountCell")
        
        networkingService.loadNews { [weak self] result in
            switch result {
            case let .success(value):
                self?.news = value
                self?.tableView.reloadData()
            case .failure:
                break
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch NewsType.allCases[indexPath.row] {
        case .image:
            let cellIdentifier = "NewsImageCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsImageCell else { return UITableViewCell() }
            
            cell.configure(with: news[indexPath.section])
            return cell
        case .likes:
            let cellIdentifier = "NewsLikesCountCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsLikesCountCell else { return UITableViewCell() }
            
            cell.configure(with: news[indexPath.section])
            return cell
        case .source:
            let cellIdentifier = "NewsSourceCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsSourceCell else { return UITableViewCell() }
            
            cell.configure(with: news[indexPath.section])
            return cell
        case .text:
            let cellIdentifier = "NewsTextCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTextCell else { return UITableViewCell() }
            
            cell.configure(with: news[indexPath.section])
            return cell
        }
    }
}
