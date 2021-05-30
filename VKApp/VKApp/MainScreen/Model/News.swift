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
    let name: String
    let urlString: String?
    let isLiked: Bool
    let sourceId: Int
    let date: Date
    
    var source: NewsSource?
    //let description: String?
    //let date: Date?
    //let pics: [UIImage?]
    
    init(json: JSON) {
        self.name = json["text"].stringValue
        self.urlString = json["attachments"].arrayValue.first(where: { $0["type"] == "photo" })?["photo"]["sizes"].arrayValue.last?["url"].stringValue
        self.isLiked = json["is_favorite"].boolValue
        self.sourceId = json["source_id"].intValue
        self.date = Date(timeIntervalSince1970: json["date"].doubleValue)
    }
}
