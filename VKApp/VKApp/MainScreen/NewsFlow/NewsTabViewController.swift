//
//  NewsTabViewController.swift
//  VKApp
//
//  Created by Ksusha on 06.03.2021.
//

import UIKit

class NewsTabViewController: UITableViewController {

    var addedNews = [
        News(name: "Новость первая", mainPic: UIImage(named: "bears")!, isLiked: false),
        News(name: "Новость вторая", mainPic: UIImage(named: "bears")!, isLiked: false),
        News(name: "Новость третья", mainPic: UIImage(named: "bears")!, isLiked: false),
        News(name: "Новость четвертая", mainPic: UIImage(named: "bears")!, isLiked: false),
        News(name: "Новость пятая", mainPic: UIImage(named: "bears")!, isLiked: false),
        News(name: "Новость шестая", mainPic: UIImage(named: "bears")!, isLiked: false),
        News(name: "Новость седьмая", mainPic: UIImage(named: "bears")!, isLiked: false),
    ]
                
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: NewsRichCell.nibName, bundle: nil), forCellReuseIdentifier: NewsRichCell.reuseIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsRichCell.reuseIdentifier, for: indexPath) as? NewsRichCell else { return UITableViewCell() }
        cell.configure(with: addedNews[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
        print("Remove at index \(indexPath.row) with name \(addedNews[indexPath.row].name) ")
           addedNews.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
           //print(addedNews)
       }
   }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowNewsSegue", sender: nil) //ShowNewsUnwindSegue
    }
}
     
//
//extension NewsTabViewController: UITableViewDataSource {
//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return addedNews.count
//   }
//
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//       guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsRichCell.reuseIdentifier, for: indexPath) as? NewsRichCell else { return UITableViewCell() }
//
//        cell.newsNameLabel.text = addedNews[indexPath.row].name
//        //print(cell.friendLabel.text)
//        return cell
//   }
//}
