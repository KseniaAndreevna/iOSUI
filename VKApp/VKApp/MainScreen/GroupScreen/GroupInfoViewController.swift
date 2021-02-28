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
        GroupPic(name: "Rockers", date: Date(), groupPic: UIImage(named: "panda-go-panda")!),
        GroupPic(name: "Rockers", date: Date(), groupPic: UIImage(named: "panda-go-panda")!),
        GroupPic(name: "Rockers", date: Date(), groupPic: UIImage(named: "panda-go-panda")!),
    ]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: FriendInfoCell.reuseIdentifier)
        //friendName = displayedFriend?.firstName + " " + displayedFriend?.surname
        title = displayedGroup?.name
        // Do any additional setup after loading the view.
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
