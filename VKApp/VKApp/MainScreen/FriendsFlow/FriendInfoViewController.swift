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
//    var vkPhotos = [VKPhoto]()
    
    private lazy var friends: Results<User>? =
        try? Realm(configuration: RealmService.deleteIfMigration)
        .objects(User.self)
        .filter("firstName == %@", displayedFriend?.id ?? "")
    
//    private lazy var friend: User? =
//        try? Realm(configuration: RealmService.deleteIfMigration)
//        .object(ofType: User.self, forPrimaryKey: displayedFriend?.id ?? -1)
    
    private lazy var friend: User? =
        displayedFriend.flatMap {
            try? Realm(configuration: RealmService.deleteIfMigration)
                .object(ofType: User.self, forPrimaryKey: $0.id)
        }

    var friendDetail = [VKPhoto]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        friendNameLabel.title = (displayedFriend?.lastName ?? "") + " " + (displayedFriend?.firstName ?? "")
        
        collectionView.dataSource = self
        
        notificationToken = friend?.observe { [weak self] changes in
            switch changes {
            case .deleted:
                self?.navigationController?.popViewController(animated: true)
            case .change:
                self?.collectionView.reloadData()
            case .error:
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentFriend = displayedFriend?.id {
            networkSession.loadPhotos(owner: currentFriend, completionHandler: { [weak self] result in //617849582
                switch result {
                case let .failure(error):
                    print(error)
                case let .success(photos):
                    guard let friend = self?.friend else { return }
                    do {
                        let realm = try Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))
                        try realm.write {
                            friend.photos.removeAll()
                            friend.photos.append(objectsIn: photos)
                        }
                    } catch {
                        print(error)
                    }
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
        return friend?.photos.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendInfoCell.reuseIdentifier, for: indexPath) as? FriendInfoCell else { return UICollectionViewCell() }
    
        friendName = (displayedFriend?.lastName ?? "") + " " + (displayedFriend?.firstName ?? "")
        
        if let photo = friend?.photos[indexPath.item] {
            cell.configure(with: photo)
        }
        
        return cell
    }
}
