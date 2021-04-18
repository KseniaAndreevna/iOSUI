//
//  GroupsViewController.swift
//  VKApp
//
//  Created by Ksusha on 21.02.2021.
//

import UIKit

class GroupInfoViewController: UICollectionViewController {
    
    var displayedGroup: Group?
    
    @IBOutlet var groupNameLabel: UINavigationItem!
    
    let groupDetail = [
        GroupPic(name: "Rockers", date: Date(), pic: UIImage(named: "panda-go-panda")!),
        GroupPic(name: "Rockers", date: Date(), pic: UIImage(named: "panda-go-panda")!),
        GroupPic(name: "Rockers", date: Date(), pic: UIImage(named: "panda-go-panda")!),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        groupNameLabel.title = displayedGroup?.name
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return groupDetail.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupInfoCell.reuseIdentifier, for: indexPath) as? GroupInfoCell else { return UICollectionViewCell() }
    
        cell.configure(with: groupDetail[indexPath.item])
        
        return cell
    }
    
}
