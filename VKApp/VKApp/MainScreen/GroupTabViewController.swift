//
//  GroupTabViewController.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit

class GroupTabViewController: UIViewController {
    
    var addedGroups = [
        Group(groupId: 123, name: "Rockers", description: nil, mainPic: nil, pics: [nil]),
        Group(groupId: 234, name: "Programmers", description: nil, mainPic: nil, pics: [nil]),
        Group(groupId: 345, name: "Economists", description: nil, mainPic: nil, pics: [nil]),
        Group(groupId: 456, name: "Students", description: "Students of Oxford", mainPic: nil, pics: [nil]),
        Group(groupId: 567, name: "Skiers", description: nil, mainPic: nil, pics: [nil]),
        Group(groupId: 678, name: "Snowboarders", description: "Snowboarder of Russia", mainPic: nil, pics: [nil]),
    ]
    
    @IBOutlet var tableGroupView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableGroupView.dataSource = self
        tableGroupView.delegate = self

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGroupSegue",
            let senderCell = sender as? FriendCell,
            let cellIndexPath = tableGroupView.indexPath(for: senderCell),
            let userViewController = segue.destination as? GroupTabViewController {
            let selectedGroup = addedGroups[cellIndexPath.row]
                
            print(#function)
            print(userViewController.description + " " + selectedGroup.name)
            //userViewController.displayedGroups = selectedGroup
      }
   }
        
//        @IBAction func showGroup(segue: UIStoryboardSegue) {
//            if let showGroupViewController = segue.source as? GroupsViewController,
//               let selectedIndexPath = showGroupViewController.tableView.indexPathForSelectedRow {
//                let selectedGroup = showGroupViewController.[selectedIndexPath.row]
//    
//                if !addedGroups.contains(selectedGroup) {
//                    addedGroups.append(selectedGroup)
//                    tableGroupView.reloadData()
//                }
//            }
//        }

}

extension GroupTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
        
        cell.groupLabel.text = addedGroups[indexPath.row].name
        print(#function)
        return cell
    }
}

extension GroupTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            addedGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
