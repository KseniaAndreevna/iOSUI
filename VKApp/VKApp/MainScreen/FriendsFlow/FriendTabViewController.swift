//
//  UserTabViewController.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit

class FriendTabViewController: UIViewController {

    var addedFriends = [
        Friend(userId: 12345, firstName: "Ivan", surname: "Ivanov", avatar: UIImage(named: "bears")!, pics: [nil]),
        Friend(userId: 19872, firstName: "Petr", surname: "Petrov", avatar: UIImage(named: "bears")!, pics: [nil]),
        Friend(userId: 12687, firstName: "Nick", surname: "Nikolaev", avatar: UIImage(named: "bears")!, pics: [nil]),
        Friend(userId: 31898, firstName: "Kirill", surname: "Kirillov", avatar: UIImage(named: "bears")!, pics: [nil]),
        Friend(userId: 13493, firstName: "Oleg", surname: "Tinkov", avatar: UIImage(named: "bears")!, pics: [nil]),
        Friend(userId: 86762, firstName: "Artur", surname: "Naumov", avatar: UIImage(named: "bears")!, pics: [nil]),
        Friend(userId: 27367, firstName: "George", surname: "Wolf", avatar: UIImage(named: "bears")!, pics: [nil]),
    ]
    
    @IBOutlet var tableView: UITableView!
    
    var sectionedFriends: [FriendSection] {
        addedFriends.reduce(into: []) {
            currentSectionFriends, friend in
            guard let firstLetter = friend.surname.first else { return }
            
            if let currentSectionFriendFirstLetterIndex = currentSectionFriends.firstIndex(where: { $0.title == firstLetter }) {
                
                let oldSection = currentSectionFriends[currentSectionFriendFirstLetterIndex]
                let updatedSection = FriendSection(title: firstLetter, friends: oldSection.friends + [friend])
                currentSectionFriends[currentSectionFriendFirstLetterIndex] = updatedSection
                
            } else {
                let newSection = FriendSection(title: firstLetter, friends: [friend])
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

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowFriendSegue",
//            let senderCell = sender as? FriendCell,
//            let cellIndexPath = tableView.indexPath(for: senderCell),
//            let friendViewController = segue.destination as? FriendInfoViewController {
//            let selectedFriend = addedFriends[cellIndexPath.row]
//
//            print(#function)
//            print(friendViewController.description + " " + selectedFriend.firstName)
//            friendViewController.displayedFriend = selectedFriend
//      }
        if segue.identifier == "ShowFriendSegue",
           let cellIndexPath = tableView.indexPathForSelectedRow,
           let friendViewController = segue.destination as? FriendInfoViewController {
            let selectedFriend =  sectionedFriends[cellIndexPath.section].friends[cellIndexPath.row] //addedFriends[cellIndexPath.row]
            friendViewController.displayedFriend = selectedFriend
        }
   }
        
//        @IBAction func showFriend(segue: UIStoryboardSegue) {
//            if let showFriendViewController = segue.source as? FriendsViewController,
//               let selectedIndexPath = showFriendViewController.tableView.indexPathForSelectedRow {
//                let selectedFriend = showFriendViewController.[selectedIndexPath.row]
//
//                if !addedFriends.contains(selectedFriend) {
//                    addedFriends.append(selectedFriend)
//                    tableView.reloadData()
//                }
//            }
//        }
}

// extension FriendTabViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return addedFriends.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendCell", for: indexPath) as? FriendCell else { return UITableViewCell() }
//
//        cell.friendLabel.text = addedFriends[indexPath.row].firstName + " " + addedFriends[indexPath.row].surname
//
//        //print(cell.friendLabel.text)
//
//        return cell
//    }
//}
//
//extension FriendTabViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            print("Remove at index \(indexPath.row) with name \(addedFriends[indexPath.row].surname) ")
//            addedFriends.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            //print(addedFriends)
//        }
//    }
//}

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
    //cell.separatorInset = UIEdgeInsets
    
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
            addedFriends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowFriendSegue", sender: nil)
    }
}
