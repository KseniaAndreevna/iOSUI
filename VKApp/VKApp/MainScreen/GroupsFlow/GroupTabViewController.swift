//
//  GroupTabViewController.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit
import RealmSwift

class GroupTabViewController: UIViewController, UISearchResultsUpdating {
    
    var searchResults: [Group] = []
    let searchController = UISearchController(searchResultsController: nil)
    private let networkSession = NetworkService(token: Session.shared.token)
    private var notificationToken: NotificationToken?
    private lazy var groups: Results<Group>? = {
        try? Realm().objects(Group.self)
    }()
    
    let operationQueue: OperationQueue = {
        let q = OperationQueue()
        q.maxConcurrentOperationCount = 4
        q.name = "ru.group.parsing.operations"
        q.qualityOfService = .userInitiated
        return q
    }()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
//        tableView.delegate = self
        
        //для использования xib-ячейки
        tableView.register(UINib(nibName: GroupRichCell.nibName, bundle: nil), forCellReuseIdentifier: GroupRichCell.reuseIdentifier)
        tableView.register(GroupAlphabetHeaderView.self, forHeaderFooterViewReuseIdentifier: GroupAlphabetHeaderView.reuseIdentifier)
        
        //UISearchBar
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        self.tableView.contentOffset = CGPoint(x: 0, y: searchController.searchBar.frame.height)
        searchController.searchBar.placeholder = "Find..."
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        notificationToken = groups?.observe { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //VK
        let downloadOperation = LoadDataOperation(
            url: URL(string: "https://api.vk.com/method/groups.get")!,
            method: .get,
            parameters: [
                "access_token": Session.shared.token,
                "extended": 1,
                "v": "5.92"
            ]
        )
        let parsingOperation = ParsingOperation<GroupResponse>()
        parsingOperation.addDependency(downloadOperation)
        
        let realmSavingDataOperation = RealmSavingOperation<GroupResponse>()
        realmSavingDataOperation.addDependency(parsingOperation)
        
        operationQueue.addOperations([downloadOperation, parsingOperation, realmSavingDataOperation], waitUntilFinished: false)
    }
    
    func filterContent(for searchText: String) {
//        searchResults = addedGroups.filter({ (group: Group) -> Bool in
//            let match = group.name.range(of: searchText, options: .caseInsensitive)
//            return match != nil
//        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "ShowGroupSegue",
        //            let senderCell = sender as? GroupCell,
        //            let cellIndexPath = tableView.indexPath(for: senderCell),
        //            let groupViewController = segue.destination as? GroupInfoViewController {
        //            let selectedGroup = addedGroups[cellIndexPath.row]
        //
        //            print(#function)
        //            print(groupViewController.description + " " + selectedGroup.name)
        //            groupViewController.displayedGroup = selectedGroup
        //      }
//        if segue.identifier == "ShowGroupSegue",
//           let cellIndexPath = tableView.indexPathForSelectedRow,
//           let groupViewController = segue.destination as? GroupInfoViewController {
//            let selectedGroup =  sectionedGroups[cellIndexPath.section].groups[cellIndexPath.row] //addedGroups[cellIndexPath.row]
//
//            groupViewController.displayedGroup = selectedGroup
//        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        if let addGroupViewController = segue.source as? AddGroupTableViewController,
//           let selectedIndexPath = addGroupViewController.tableView.indexPathForSelectedRow {
//            let selectedGroup = addGroupViewController.groups[selectedIndexPath.row]
//
//            if !addedGroups.contains(selectedGroup) {
//                addedGroups.append(selectedGroup)
//                tableView.reloadData()
//            }
//        }
    }
}

//extension GroupTabViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return addedGroups.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
//
//        cell.groupLabel.text = addedGroups[indexPath.row].name
//        print(#function)
//        return cell
//    }
//}

extension GroupTabViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        //return sectionedGroups.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return sectionedGroups[section].groups.count
        return groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupRichCell.reuseIdentifier, for: indexPath) as? GroupRichCell else { return UITableViewCell() }
        //
        //        cell.configure(with: sectionedGroups[indexPath.section].groups[indexPath.row])
        //        cell.selectionStyle = .none
        //
        //        return cell
        guard let entry = groups?[indexPath.row] else { return UITableViewCell() }
        //sectionedSearchGroups[indexPath.section].groups[indexPath.row] : sectionedGroups[indexPath.section].groups[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupRichCell.reuseIdentifier, for: indexPath) as? GroupRichCell else { return UITableViewCell() }
        cell.configure(with: entry)
        cell.selectionStyle = .none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: GroupAlphabetHeaderView.reuseIdentifier) as? GroupAlphabetHeaderView else { return nil }
//
//        let firstLetter = String(sectionedGroups[section].title)
//        header.headerTitle.text = firstLetter
//
//        return header
//    }
}

//extension GroupTabViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            addedGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "ShowGroupSegue", sender: nil)
//    }
//}


