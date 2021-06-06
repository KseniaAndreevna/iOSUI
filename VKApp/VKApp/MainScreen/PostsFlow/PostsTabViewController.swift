//
//  PostsTabViewController.swift
//  VKApp
//
//  Created by Ksenia Volkova on 09.05.2021.
//

import UIKit

class PostsTabViewController: UITableViewController {
    
    private let networkSession = NetworkService(token: Session.shared.token)
    
    let operationQueue: OperationQueue = {
        let q = OperationQueue()
        q.maxConcurrentOperationCount = 4
        q.name = "ru.group.parsing.operations"
        q.qualityOfService = .userInitiated
        return q
    }()
    
//    var posts = [
//        Posts(header: "Пост первый", mainPic: UIImage(named: "bears")!, description: "Краткое описание первого поста Параллельное программирование — это способ организации параллельных, одновременных вычислений в программе. В традиционной последовательной модели код выполняется по порядку, и в конкретный момент времени может обрабатываться только одно действие. Параллельное программирование позволяет решать несколько задач одновременно. Например, вы можете отрисовывать прокрутку таблицы, загружая данные из интернета. При последовательном способе ваш интерфейс замрёт и не будет реагировать на запросы пользователя, пока не завершит загрузку данных. Для начала разберёмся, из чего состоит и как работает приложение. На каком языке программирования или для какой операционной системы вы бы ни писали приложение, в конечном счеёте его будет выполнять процессор. Он может распознавать простейшие команды — например, сложение или сравнение двух значений в памяти. Из последовательности таких команд и строится работа компьютера. Самые первые компьютеры, собственно, ничего другого и не умели — на них не было операционной системы в современном понимании. Программирование представляло собой перевод математических действий в простейшие операции, которые мог выполнить процессор. По сути, это был просто большой и быстрый калькулятор. Кстати, от английского to compute — «вычислять» и происходит слово «компьютер», буквально — «вычислитель». Время шло, компьютеры становились быстрее, их научили не только производить вычисления, но и отображать данные на мониторе, выводить их на печать, считывать символы с клавиатуры. Появилось множество программ, при работе с которыми пользователю понадобилась возможность запускать их одну за другой, выбирать и чередовать. Первоначальный подход, когда компьютер действовал по чёткой последовательной инструкции, устарел.Тогда и появились операционные системы (ОС). Это обычные программы — по типу самых первых программных продуктов. При запуске ОС загружается в память устройства, и процессор начинает её выполнение. При этом система может запускать в своём контексте другие программы, передавать их код процессору, управлять их выполнением.", bodyText: "Тело первого поста", date: Date(), pics:[], isLiked: false, isReposted: false),
//        Posts(header: "Пост второй", mainPic: UIImage(named: "bears")!, description: "Краткое описание второго поста", bodyText: "Тело второго поста", date: Date(), pics:[], isLiked: false, isReposted: false),
//    ]
    
    var posts = [Post]()
                
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: PostsRichCell.nibName, bundle: nil), forCellReuseIdentifier: PostsRichCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkSession.loadPosts(completionHandler: { [weak self] result in
            switch result {
            case let .success(postsVK):
                self?.posts = postsVK
                try? RealmService.save(items: postsVK, configuration: RealmService.deleteIfMigration, update: .modified)
                self?.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsRichCell.reuseIdentifier, for: indexPath) as? PostsRichCell else { return UITableViewCell() }
        //cell.configure(with: posts[indexPath.row])
        //cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
        print("Remove at index \(indexPath.row) with name \(posts[indexPath.row].text) ")
           posts.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
           //print(posts)
       }
   }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "ShowPostsSegue", sender: nil) //ShowPostsUnwindSegue
//    }
}
     
//
//extension PostsTabViewController: UITableViewDataSource {
//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return posts.count
//   }
//
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//       guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsRichCell.reuseIdentifier, for: indexPath) as? PostsRichCell else { return UITableViewCell() }
//
//        cell.postsNameLabel.text = addedNews[indexPath.row].name
//        //print(cell.friendLabel.text)
//        return cell
//   }
//}
