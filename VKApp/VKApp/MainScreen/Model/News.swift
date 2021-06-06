//
//  News.swift
//  VKApp
//
//  Created by Ksusha on 06.03.2021.
//

import UIKit
import SwiftyJSON

protocol NewsSource {
    var name: String { get }
    var imageUrlString: String { get }
}

extension NewsSource {
    var imageUrl: URL? { URL(string: imageUrlString) }
}

struct News {
    var url: URL? { urlString.flatMap { URL(string: $0) } }
    let text: String
    var urlString: String?
    let isLiked: Bool
    let sourceId: Int
    let date: Date
    var type: String
    var postId: Double
    var likesCount: Int
    var repostsCount: Int
    var commentsCount: Int
    var photoWidth = 0
    var photoHeight = 0
    
    var aspectRatio: CGFloat {
        guard photoWidth != 0 else { return 0 }
        return CGFloat(photoHeight)/CGFloat(photoWidth)
    }
    
    var cellsRequired: [NewsType] {
        var cellsRequired = [NewsType]()
        
        if sourceId != 0 {
            cellsRequired.append(.source)
        }
        
        if urlString != nil {
            cellsRequired.append(.image)
        }
        
        if !text.isEmpty {
            cellsRequired.append(.text)
        }
        
        // isLiked cell is always possible to build, because isLiked property is not optional
        cellsRequired.append(.likes)
        
        return cellsRequired
    }
    
    var source: NewsSource?
    //let description: String?
    //let date: Date?
    //let pics: [UIImage?]
    
    init(json: JSON) {
        self.text = json["text"].stringValue
//        self.urlString = json["photos"]["items"].arrayValue.first(where: { $0["type"] == "photo" })?["photo"]["sizes"].arrayValue.last?["url"].stringValue
        // json["attachments"].arrayValue.first //for post
        self.urlString = json["attachments"].arrayValue.first(where: { $0["type"] == "photo" })?["photo"]["sizes"].arrayValue.last?["url"].stringValue
        
        self.isLiked = json["is_favorite"].boolValue
        self.sourceId = json["source_id"].intValue
        self.date = Date(timeIntervalSince1970: json["date"].doubleValue)
        self.type = json["type"].stringValue
        self.postId = json["post_id"].doubleValue
        self.likesCount = json["likes"]["count"].intValue
        self.repostsCount = json["reposts"]["count"].intValue
        self.commentsCount = json["comments"]["count"].intValue
        
        if type == "post" {
            let attachment = json["attachments"][0]
            switch attachment["type"] {
            case "photo":
                let photoSizes = attachment["photo"]["sizes"].arrayValue
                guard let photoSizeX = photoSizes.last
                else {
                    print("Error")
                    return
                }
                self.urlString = photoSizeX["url"].stringValue
                self.photoWidth = photoSizeX["width"].intValue
                self.photoHeight = photoSizeX["height"].intValue
            default:
                self.urlString = ""
            }
        }
    }
}
/*
"response": {
"items": [{
"source_id": 59826656,
"date": 1622643972,
"photos": {
"count": 3,
"items": [{
"album_id": 220262671,
"date": 1622643330,
"id": 457250266,
"owner_id": 59826656,
"has_tags": false,
"access_key": "aedfff3226608baf99",
"sizes": [{
"height": 75,
"url": "https://sun9-24.u...grX8&type=album",
"type": "s",
"width": 50
},
*/
