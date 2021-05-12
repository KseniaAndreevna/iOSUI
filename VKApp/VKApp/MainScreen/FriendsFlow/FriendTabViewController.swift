//
//  UserTabViewController.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit
import RealmSwift

class FriendTabViewController: UIViewController {
    
    private let networkSession = NetworkService(token: Session.shared.token)
    
    let friends: Results<User>? = try? RealmService.get(type: User.self)
    var notificationToken: NotificationToken?
    
    @IBOutlet var tableView: UITableView!
    
    var sectionedFriends: [UserSection] {
        guard let friends = friends else { return [] }
        return friends.reduce(into: [UserSection]() ) {
            currentSectionFriends, friend in
            guard let firstLetter = friend.lastName.first else { return }
            
            if let currentSectionFriendFirstLetterIndex = currentSectionFriends.firstIndex(where: { $0.title == firstLetter }) {
                
                let oldSection = currentSectionFriends[currentSectionFriendFirstLetterIndex]
                let updatedSection = UserSection(title: firstLetter, friends: oldSection.friends + [friend])
                currentSectionFriends[currentSectionFriendFirstLetterIndex] = updatedSection
                
            } else {
                let newSection = UserSection(title: firstLetter, friends: [friend])
                currentSectionFriends.append(newSection)
            }
        }.sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: FriendRichCell.nibName, bundle: nil), forCellReuseIdentifier: FriendRichCell.reuseIdentifier)
        tableView.register(FriendAlphabetHeaderView.self, forHeaderFooterViewReuseIdentifier: FriendAlphabetHeaderView.reuseIdentifier)
        
        notificationToken = friends?.observe { [weak self] changes in
            switch changes {
            case .initial:
                break
            case .update:
                self?.tableView.reloadData()
            case let .error(error):
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkSession.loadFriends(completionHandler: { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):
                try? RealmService.save(items: friends, configuration: RealmService.deleteIfMigration, update: .modified)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendSegue",
           let cellIndexPath = tableView.indexPathForSelectedRow,
           let friendViewController = segue.destination as? FriendInfoViewController {
            let selectedFriend = sectionedFriends[cellIndexPath.section].friends[cellIndexPath.row]
            friendViewController.displayedFriend = selectedFriend
        }
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        
    }
}

extension FriendTabViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedFriends.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sectionedFriends[section].friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendRichCell.reuseIdentifier, for: indexPath) as? FriendRichCell else { return UITableViewCell() }
        
        cell.configure(with: sectionedFriends[indexPath.section].friends[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendAlphabetHeaderView.reuseIdentifier) as? FriendAlphabetHeaderView else { return nil }
        
        let firstLetter = String(sectionedFriends[section].title)
        header.headerTitle.text = firstLetter
        
        return header
    }
    
}

extension FriendTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete,
           let friendToDelete = friends?[indexPath.row] {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.delete(friendToDelete)
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowFriendSegue", sender: nil)
    }
}
