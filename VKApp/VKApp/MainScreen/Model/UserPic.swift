//
//  UserPic.swift
//  VKApp
//
//  Created by Ksusha on 28.02.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

struct UserPic {
    var name: String
    let date: Date
    let userPic: UIImage
}

//"items": [
//            {
//                "album_id": -6,
//                "date": 1302989779,
//                "id": 250047610,
//                "owner_id": 1556249,
//                "has_tags": false,
//                "post_id": 326,
//                "sizes": [
//                    {
class Photo {
    let albumId: Int
    let date: Date
    let sizes: [Size]
    
    init(json: JSON) {
        self.albumId = json["album_id"].intValue
        self.date = Date(timeIntervalSince1970: json["date"].doubleValue)
        let sizesJSONArray = json["sizes"].arrayValue
        self.sizes = sizesJSONArray.map(Size.init)
    }
}

struct Size {
    let url: String
    let type: String
    let width: Int
    let height: Int
    
    init(json: SwiftyJSON.JSON) {
        self.url = json["url"].stringValue
        self.type = json["type"].stringValue
        self.width = json["width"].intValue
        self.height = json["height"].intValue
    }
}


class VKPhoto: RealmSwift.Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    var sizes = [VKPhotoSize]()
    var count: Int?

    convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.ownerId = json["owner_id"].intValue
    }
}

class VKPhotoSize {
    let type: String
    private let photoUrlString : String

    var photoUrl: URL? { URL(string: photoUrlString) }
    
    init(json: JSON) {
        self.type = json["type"].stringValue
        self.photoUrlString = json["url"].stringValue
    }
}
