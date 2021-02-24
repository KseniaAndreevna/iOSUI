//
//  MainViewController.swift
//  VKApp
//
//  Created by Ksusha on 21.02.2021.
//

import UIKit

class MainViewController: UITabBarController {
    
//    var addedFriends = [
//        User(firstName: "Ivan", surname: "Ivanov"),
//        User(firstName: "Petr", surname: "Petrov"),
//        User(firstName: "Nick", surname: "Nikolaev"),
//        User(firstName: "Irina", surname: "Watson"),
//    ]
    
//    var addedGroups = [
//        Group(name: "Rockers"),
//        Group(name: "Programmers"),
//        Group(name: "Economists"),
//        Group(name: "Students"),
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(addedFriends)
        //print(addedGroups)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func dismissBarButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowFriendSegue",
//           let senderCell = sender as? UserCell,
//           let cellIndexPath = tableView.indexPath(for: senderCell),
//           let friendViewController = segue.destination as FriendsViewController {
//            let selectedUser = addedFriends[cellIndexPath.row]
//            
//            friendViewController.displayedCity = selectedUser
//        }
//    }
    
    //@IBAction func dismissButtonPressed(_ sender: UIButton) {
        //self.dismiss(animated: true)
    //    navigationController?.popViewController(animated: true)
    //}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension MainViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return addedFriends.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendCell", for: indexPath) as? UserCell else { return UITableViewCell() }
//        
//        cell.userLabel.text = addedFriends[indexPath.row].firstName + " " + addedFriends[indexPath.row].surname
//        
//        return cell
//    }
//}
//
//extension MainViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            addedFriends.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//}

