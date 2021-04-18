//
//  FriendCollViewController.swift
//  VKApp
//
//  Created by Ksusha on 28.02.2021.
//

import UIKit
import RealmSwift

//private let reuseIdentifier = "FriendInfoCell"

class FriendInfoViewController: UICollectionViewController {
    
    var displayedFriend: User?
    
    private let networkSession = NetworkService(token: Session.shared.token)
    
    @IBOutlet var friendNameLabel: UINavigationItem!
    var friendName: String = ""
    
    private lazy var friends: Results<User>? = try? Realm(configuration: RealmService.deleteIfMigration).objects(User.self).filter("firstName == %@", displayedFriend?.firstName ?? "")
    
    var friendDetail = [
        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: FriendInfoCell.reuseIdentifier)
        //print("друг \(displayedFriend!.userId)")
        friendNameLabel.title = (displayedFriend?.lastName ?? "") + " " + (displayedFriend?.firstName ?? "")
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentFriend = displayedFriend?.firstName {
            networkSession.friend(for: currentFriend, completion: { [weak self] result in
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(forecasts):
                    try? RealmService.save(items: forecasts)
                    self?.collectionView.reloadData()
                }
            })
        }
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
    
        friendName = (displayedFriend?.lastName ?? "") + " " + (displayedFriend?.firstName ?? "")
        friendDetail[indexPath.item].name = friendName
        cell.configure(with: friendDetail[indexPath.item])
        
        return cell
    }
}
