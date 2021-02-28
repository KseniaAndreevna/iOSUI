//
//  UserTabViewController.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit

class FriendTabViewController: UIViewController {

    var addedFriends = [
        Friend(userId: 12345, firstName: "Ivan", surname: "Ivanov", avatar: nil, pics: [nil]),
        Friend(userId: 19872, firstName: "Petr", surname: "Petrov", avatar: nil, pics: [nil]),
        Friend(userId: 12687, firstName: "Nick", surname: "Nikolaev", avatar: nil, pics: [nil]),
        Friend(userId: 31898, firstName: "Nick", surname: "Nikolaev", avatar: nil, pics: [nil]),
        Friend(userId: 13493, firstName: "Oleg", surname: "Tinkov", avatar: nil, pics: [nil]),
        Friend(userId: 86762, firstName: "Artur", surname: "Naumov", avatar: nil, pics: [nil]),
        Friend(userId: 27367, firstName: "George", surname: "Wolf", avatar: nil, pics: [nil]),
    ]
    
    @IBOutlet var tableUserView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableUserView.dataSource = self
        tableUserView.delegate = self

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendSegue",
            let senderCell = sender as? FriendCell,
            let cellIndexPath = tableUserView.indexPath(for: senderCell),
            let friendViewController = segue.destination as? FriendCollViewController {
            let selectedFriend = addedFriends[cellIndexPath.row]
                
            print(#function)
            print(friendViewController.description + " " + selectedFriend.firstName)
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
//                    tableUserView.reloadData()
//                }
//            }
//        }
}

 extension FriendTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendCell", for: indexPath) as? FriendCell else { return UITableViewCell() }
        
        cell.friendLabel.text = addedFriends[indexPath.row].firstName + " " + addedFriends[indexPath.row].surname
        
        //print(cell.friendLabel.text)
        
        return cell
    }
}

extension FriendTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Remove at index \(indexPath.row) with name \(addedFriends[indexPath.row].surname) ")
            addedFriends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //print(addedFriends)
        }
    }
}
