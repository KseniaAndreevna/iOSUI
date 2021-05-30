//
//  FriendRichCell.swift
//  VKApp
//
//  Created by Ksusha on 03.03.2021.
//

import UIKit
import Kingfisher

class FriendRichCell: UITableViewCell {
    
    static let reuseIdentifier = "FriendRichCell"
    static let nibName = "FriendRichCell"
    
    var photoService: PhotoService?
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    
    @IBOutlet var friendShadowView: UIView!
    @IBOutlet var friendNameLabel: UILabel!
    //@IBOutlet var dateLabel: UILabel!
    @IBOutlet var friendIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        friendIconImageView.clipsToBounds = true
        friendShadowView.layer.shadowColor = UIColor.systemBlue.cgColor
        friendShadowView.layer.shadowRadius = 4
        friendShadowView.layer.shadowOpacity = 0.8
        
        //        let tapGesture = UITapGestureRecognizer()
        //        tapGesture.addTarget(self, action: #selector(tapGestureDetected))
        //        self.friendIconImageView.addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        friendIconImageView.layer.cornerRadius = friendIconImageView.bounds.width/2
        friendShadowView.layer.cornerRadius = friendShadowView.bounds.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    } 
    
    public func configure(with friend: User) {
        friendNameLabel.text = "\(friend.firstName) \(friend.lastName)"
        friendIconImageView.kf.setImage(with: friend.photoUrl)
        saveFriendPicToDir(url: friend.photoUrlString, image: friendIconImageView.image ?? UIImage(named: "panda01")!)
    }
    
    func saveFriendPicToDir (url: String, image: UIImage) {
        saveImageToCache(url: url, image: image)
        //photoService?.picture(byUrl: imageUrl)
        //DispatchQueue.main.async { [self] in
        // photoService!.images[String(describing: friend.photoUrl)] = friendIconImageView.image
        // }
        //photoService!.saveImageToCache(url: String(describing: friend.photoUrl), image: friendIconImageView.image! )
    }
    
    func getFilePath(url: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        print("cachesDirectory \(cachesDirectory)")
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
        let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    func getImageFromCache(url: String) -> UIImage? {
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
            else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }

//        DispatchQueue.main.async { [self] in
//            images[url] = image
//        }
        return image
    }
    
    
    @objc func tapGestureDetected(_ gesture: UITapGestureRecognizer) {
        //animateFriendPic()
        print(#function)
    }

    func animateFriendPic() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.friendIconImageView.layer.add(animation, forKey: nil)
    }
    
}
