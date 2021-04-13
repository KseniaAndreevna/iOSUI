//
//  UserTabViewController.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit

class FriendTabViewController: UIViewController {
    
    private let networkSession = NetworkService(token: Session.shared.token)
    
    var friends = [User]()
    
    @IBOutlet var tableView: UITableView!
    
    var sectionedFriends: [UserSection] {
        friends.reduce(into: []) {
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendSegue",
           let cellIndexPath = tableView.indexPathForSelectedRow,
           let friendViewController = segue.destination as? FriendInfoViewController {
            let selectedFriend = sectionedFriends[cellIndexPath.section].friends[cellIndexPath.row]
            friendViewController.displayedFriend = selectedFriend
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        networkSession.loadFriends(completionHandler: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(friends):
                self?.friends = friends
                self?.tableView.reloadData()
            }
        })
        networkSession.loadPics(token: Session.shared.token)
        
        let realmUser = [User(id: 123456789, firstName: "Test", lastName: "Test"),
                         User(id: 987654321, firstName: "Test2", lastName: "Test2")]
        networkSession.saveUserData(realmUser)
        networkSession.loadUserData()
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
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowFriendSegue", sender: nil)
    }
}
