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
    
    private var notificationToken: NotificationToken?
    
    @IBOutlet var friendNameLabel: UINavigationItem!
    var friendName: String = ""
    var vkFriends: User?
    var vkPhotos = [VKPhoto]()
    
    private lazy var friends: Results<User>? =
        try? Realm(configuration: RealmService.deleteIfMigration)
        .objects(User.self)
        .filter("firstName == %@", displayedFriend?.firstName ?? "")
    
//    var friendDetail = [
//        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
//        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
//        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
//        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
//        UserPic(name: "", date: Date(), userPic: UIImage(named: "panda-go-panda")!),
//    ]

    var friendDetail = [VKPhoto]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         //self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: FriendInfoCell.reuseIdentifier)
        //print("друг \(displayedFriend!.userId)")
        friendNameLabel.title = (displayedFriend?.lastName ?? "") + " " + (displayedFriend?.firstName ?? "")
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        
//        notificationToken = friends?.observe { [weak self] changes in //vkPhotos.first?.observe
//            switch changes {
//            case .initial:
//                self?.collectionView.reloadData()
//            case let .update(_, deletions, insertions, modifications):
//                self?.collectionView.apply(deletions: deletions, insertions: insertions, modifications: modifications)
//            case let .error(error):
//                self?.show(error: error)
//            }
//        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentFriend = displayedFriend?.id {
            //networkSession.friend(for: currentFriend, completion: { [weak self] result in
            networkSession.loadPhotos(owner: currentFriend, completionHandler: { [weak self] result in //617849582
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(photos):
                    try? RealmService.save(items: photos)
                    self?.vkPhotos = photos
                    self?.collectionView.reloadData()
                }
            })
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return friendDetail.count
        return vkPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendInfoCell.reuseIdentifier, for: indexPath) as? FriendInfoCell else { return UICollectionViewCell() }
    
        friendName = (displayedFriend?.lastName ?? "") + " " + (displayedFriend?.firstName ?? "")
        //friendDetail[indexPath.item].name = friendName
        //friendDetail[indexPath.item].id = displayedFriend!.id
        //cell.configure(with: friendDetail[indexPath.item])
        cell.configure(with: vkPhotos[indexPath.item])
        return cell
    }
}
