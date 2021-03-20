//
//  AddGroupTableViewController.swift
//  VKApp
//
//  Created by Ksusha on 28.02.2021.
//

import UIKit

class AddGroupTableViewController: UITableViewController {
    
    var groups = [
        Group(groupId: 233, name: "Indi-Rockers", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
        Group(groupId: 577, name: "Pop-Rockers", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
        Group(groupId: 666, name: "Rappers", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
        Group(groupId: 987, name: "Daddies", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
        Group(groupId: 790, name: "Drivers", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
        Group(groupId: 875, name: "Motorcyclists", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
    ]

        override func viewDidLoad() {
            super.viewDidLoad()
            //
            tableView.register(UINib(nibName: GroupRichCell.nibName, bundle: nil), forCellReuseIdentifier: GroupRichCell.reuseIdentifier)
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return groups.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupOutCell", for: indexPath) as? GroupCell else { return UITableViewCell() }

            // Configure the cell...
            //cell.groupLabel.text = groups[indexPath.row].name
            
            //On xib-file
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupRichCell.reuseIdentifier, for: indexPath) as? GroupRichCell else { return UITableViewCell() }

            // Configure the cell..
            cell.configure(with: groups[indexPath.row])
            
            return cell
        }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "AddGroupUnwindSegue", sender: nil)
        }
    
}
