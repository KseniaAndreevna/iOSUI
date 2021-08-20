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
    case text
    case image
    case likes
    
    func associatedCellClass() -> AnyObject.Type {
        switch self {
        case .source:
            return NewsSourceCell.self
        case .text:
            return NewsTextCell.self
        case .image:
            return NewsImageCell.self
        case .likes:
            return NewsLikesCountCell.self
        }
    }
    
    var associatedCellIdentifier: String {
        switch self {
        case .source:
            return "NewsSourceCell"
        case .text:
            return "NewsTextCell"
        case .image:
            return "NewsImageCell"
        case .likes:
            return "NewsLikesCountCell"
        }
    }
}

class NewsTabViewController: UITableViewController {
    
    let networkService = NetworkService(token: Session.shared.token)
    
    //private(set) var news: [News] = []
    private var news: [News] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var isNewsLoading = false
    private var feedNextFromAnchor: String?
    private var openedTextCells: [IndexPath: Bool] = [:]
    let textFont = UIFont.systemFont(ofSize: 14)
                
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: NewsRichCell.nibName, bundle: nil), forCellReuseIdentifier: NewsRichCell.reuseIdentifier)

        tableView.register(NewsSourceCell.self, forCellReuseIdentifier: "NewsSourceCell")
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: "NewsTextCell")
        tableView.register(NewsImageCell.self, forCellReuseIdentifier: "NewsImageCell")
        tableView.register(NewsLikesCountCell.self, forCellReuseIdentifier: "NewsLikesCountCell")
        
        networkService.loadNews { [weak self] news, nextFromAnchor in
            guard let self = self else { return }
            self.news = news
            self.feedNextFromAnchor = nextFromAnchor
//            switch result {
//            case let .success(value):
//                self?.news = value
//                self?.feedNextFromAnchor = nextFromAnchor
//                self?.tableView.reloadData()
//            case .failure:
//                break
//            }
        }
        
        // refresh control
        self.refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Loading more news...")
        refreshControl?.tintColor = .systemBlue
        refreshControl?.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        
        tableView.dataSource = self
        
        tableView.prefetchDataSource = self
    }
    
    @objc private func refreshControlPulled() {
        print("Loading...")
        
        guard let firstPost = news.first else { self.refreshControl?.endRefreshing(); return }
        
        networkService.loadNews(startTime: firstPost.date) { [weak self] newPosts, _ in
            guard let self = self else { return }
            self.news.insert(contentsOf: newPosts, at: 0)
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count 
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return NewsType.allCases.count
        return news[section].cellsRequired.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch news[indexPath.section].cellsRequired[indexPath.row] {
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
        }
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch news[indexPath.section].cellsRequired[indexPath.row] {//switch indexPath.row {
        case .source, .likes:
            return 60
        case .image:
            let aspectRatio = news[indexPath.section].aspectRatio
            return tableView.frame.width * aspectRatio
        case .text:
            let maximumCellHeight: CGFloat = 100
            let text = news[indexPath.section].text
            guard !text.isEmpty else { return 0 }
            
            let availableWidth = tableView.frame.width - 2 * NewsRichCell.horizontalInset
            let desiredLabelHeight = getLabelSize(text: text, font: textFont, availableWidth: availableWidth).height + 2 * NewsRichCell.verticalInset
            
            let isOpened = openedTextCells[indexPath] ?? false
            return isOpened ? desiredLabelHeight : min(maximumCellHeight, desiredLabelHeight)
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch news[indexPath.section].cellsRequired[indexPath.row] {//switch indexPath.row {
        case .source, .likes:
            return 60
        case .image:
            let aspectRatio = news[indexPath.section].aspectRatio
            return tableView.frame.width * aspectRatio
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard indexPath.row == 2 else { return }
        guard news[indexPath.section].cellsRequired[indexPath.row]  == .text else { return }
        let currentValue = openedTextCells[indexPath] ?? false
        openedTextCells[indexPath] = !currentValue
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

extension NewsTabViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let feedNextFromAnchor = feedNextFromAnchor,
              let maxIndexPath = indexPaths.max(),
              maxIndexPath.section >= (news.count - 3),
              !isNewsLoading else { return }
        
        isNewsLoading = true
        networkService.loadNews(nextFrom: feedNextFromAnchor) { [weak self] newPosts, nextFromAnchor in
            guard let self = self else { return }
            self.news.append(contentsOf: newPosts)
            self.isNewsLoading = false
            self.feedNextFromAnchor = nextFromAnchor
        }
    }
}

//extension PrefetchViewController : UITableViewDataSourcePrefetching {
//  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//
//    // fetch News from API for those rows that are being prefetched (near to visible area)
//    for indexPath in indexPaths {
//      self.fetchNews(ofIndex: indexPath.row)
//    }
//  }
//
//  func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//
//    // cancel the task of fetching news from API when user scroll away from them
//    for indexPath in indexPaths {
//      self.cancelFetchNews(ofIndex: indexPath.row)
//    }
//  }
//}


/// <#Description#>
/// - Parameters:
///   - text: <#text description#>
///   - font: <#font description#>
///   - availableWidth: <#availableWidth description#>
/// - Returns: <#description#>
func getLabelSize(text: String, font: UIFont, availableWidth: CGFloat) -> CGSize {
    //получаем размеры блока, в который надо вписать надпись
    //используем максимальную ширину и максимально возможную высоту
    let textBlock = CGSize(width: availableWidth, height: CGFloat.greatestFiniteMagnitude)
    //получим прямоугольник, который займёт наш текст в этом блоке, уточняем, каким шрифтом он будет написан
    let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    //получаем ширину блока, переводим ее в Double
    let width = Double(rect.size.width)
    //получаем высоту блока, переводим ее в Double
    let height = Double(rect.size.height)
    //получаем размер, при этом округляем значения до большего целого числа
    let size = CGSize(width: ceil(width), height: ceil(height))
    return size
}
