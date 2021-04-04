//
//  GroupTabViewController.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit

class GroupTabViewController: UIViewController, UISearchResultsUpdating {
    
 var searchResults: [Group] = []
 let searchController = UISearchController(searchResultsController: nil)
 private let networkSession = NetworkService()
    
 var addedGroups = [
    Group(groupId: 123, name: "Rockers", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 234, name: "Programmers", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 345, name: "Economists", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 456, name: "Students", description: "Students of Oxford", mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 567, name: "Skiers", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 678, name: "Snowboarders", description: "Snowboarders of UK", mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 999, name: "Anarchists", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 333, name: "Biologists", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 222, name: "Accountants", description: "Accountants of Moscow", mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 111, name: "Moms", description: nil, mainPic: UIImage(named: "bears")!, pics: [nil]),
    Group(groupId: 555, name: "Runners", description: "Runners of Russia", mainPic: UIImage(named: "bears")!, pics: [nil]),
    ]
    
    var sectionedGroups: [GroupSection] {
        addedGroups.reduce(into: []) {
            currentSectionGroups, group in
            guard let firstLetter = group.name.first else { return }
            
            if let currentSectionGroupFirstLetterIndex = currentSectionGroups.firstIndex(where: { $0.title == firstLetter }) {
                
                let oldSection = currentSectionGroups[currentSectionGroupFirstLetterIndex]
                let updatedSection = GroupSection(title: firstLetter, groups: oldSection.groups + [group])
                currentSectionGroups[currentSectionGroupFirstLetterIndex] = updatedSection
                
            } else {
                let newSection = GroupSection(title: firstLetter, groups: [group])
                currentSectionGroups.append(newSection)
            }
        }.sorted()
    }
    
    var sectionedSearchGroups: [GroupSection] {
        searchResults.reduce(into: []) {
            currentSectionGroups, group in
            guard let firstLetter = group.name.first else { return }
            
            if let currentSectionGroupFirstLetterIndex = currentSectionGroups.firstIndex(where: { $0.title == firstLetter }) {
                
                let oldSection = currentSectionGroups[currentSectionGroupFirstLetterIndex]
                let updatedSection = GroupSection(title: firstLetter, groups: oldSection.groups + [group])
                currentSectionGroups[currentSectionGroupFirstLetterIndex] = updatedSection
                
            } else {
                let newSection = GroupSection(title: firstLetter, groups: [group])
                currentSectionGroups.append(newSection)
            }
        }.sorted()
    }
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //VK
        networkSession.loadGroups(token: Session.shared.token)
        networkSession.searchGroup(token: Session.shared.token, group: "snowsev")
    }
    
    func filterContent(for searchText: String) {
        searchResults = addedGroups.filter({ (group: Group) -> Bool in
            let match = group.name.range(of: searchText, options: .caseInsensitive)
        return match != nil
        })
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
        if segue.identifier == "ShowGroupSegue",
           let cellIndexPath = tableView.indexPathForSelectedRow,
           let groupViewController = segue.destination as? GroupInfoViewController {
            let selectedGroup =  sectionedGroups[cellIndexPath.section].groups[cellIndexPath.row] //addedGroups[cellIndexPath.row]

            groupViewController.displayedGroup = selectedGroup
        }
   }
    
        @IBAction func addGroup(segue: UIStoryboardSegue) {
            if let addGroupViewController = segue.source as? AddGroupTableViewController,
               let selectedIndexPath = addGroupViewController.tableView.indexPathForSelectedRow {
                let selectedGroup = addGroupViewController.groups[selectedIndexPath.row]
    
                if !addedGroups.contains(selectedGroup) {
                    addedGroups.append(selectedGroup)
                    tableView.reloadData()
                }
            }
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
        return searchController.isActive ? 1 : sectionedGroups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return sectionedGroups[section].groups.count
        return searchController.isActive ? searchResults.count : sectionedGroups[section].groups.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupRichCell.reuseIdentifier, for: indexPath) as? GroupRichCell else { return UITableViewCell() }
//
//        cell.configure(with: sectionedGroups[indexPath.section].groups[indexPath.row])
//        cell.selectionStyle = .none
//
//        return cell
        let entry = searchController.isActive ?
                    searchResults[indexPath.row] : sectionedGroups[indexPath.section].groups[indexPath.row]
            //sectionedSearchGroups[indexPath.section].groups[indexPath.row] : sectionedGroups[indexPath.section].groups[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupRichCell.reuseIdentifier, for: indexPath) as? GroupRichCell else { return UITableViewCell() }
        cell.configure(with: entry)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: GroupAlphabetHeaderView.reuseIdentifier) as? GroupAlphabetHeaderView else { return nil }
        
        let firstLetter = String(sectionedGroups[section].title)
        header.headerTitle.text = firstLetter 
        
        return header
    }
}

extension GroupTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            addedGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowGroupSegue", sender: nil)        
    }
}


