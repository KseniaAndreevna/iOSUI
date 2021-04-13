//
//  AddGroupTableViewController.swift
//  VKApp
//
//  Created by Ksusha on 28.02.2021.
//

import UIKit

class AddGroupTableViewController: UITableViewController {
    
    var groups = [Group]()
    private let networkSession = NetworkService(token: Session.shared.token)

        override func viewDidLoad() {
            super.viewDidLoad()
            //
            tableView.register(UINib(nibName: GroupRichCell.nibName, bundle: nil), forCellReuseIdentifier: GroupRichCell.reuseIdentifier)
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

extension AddGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkSession.searchGroup(group: searchText, completionHandler: { [weak self] result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(groups):
                self?.groups = groups
                self?.tableView.reloadData()
            }
        })
    }
}
