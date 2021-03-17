//
//  FriendCollViewController.swift
//  VKApp
//
//  Created by Ksusha on 28.02.2021.
//

import UIKit

//private let reuseIdentifier = "FriendInfoCell"

class FriendInfoViewController: UICollectionViewController {
    
    var displayedFriend: Friend?
    
    @IBOutlet var friendNameLabel: UINavigationItem!
    var friendName: String = ""
    
    let friendDetail = [
        UserPic(name: "Ivan Ivanov", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
        UserPic(name: "Ivan Ivanov", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
        UserPic(name: "Ivan Ivanov", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
        UserPic(name: "Ivan Ivanov", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
        UserPic(name: "Ivan Ivanov", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: FriendInfoCell.reuseIdentifier)
        //print("друг \(displayedFriend!.userId)")
        friendNameLabel.title = displayedFriend!.surname + " " + displayedFriend!.firstName
        // Do any additional setup after loading the view.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return friendDetail.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendInfoCell.reuseIdentifier, for: indexPath) as? FriendInfoCell else { return UICollectionViewCell() }
    
        cell.configure(with: friendDetail[indexPath.item])
        
        return cell
    }
}
