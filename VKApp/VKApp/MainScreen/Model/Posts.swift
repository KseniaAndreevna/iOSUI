//
//  Posts.swift
//  VKApp
//
//  Created by Ksenia Volkova on 09.05.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

//{
//"response": {
//"items": [{
//"source_id": -30022666,
//"date": 1621367602,
//"can_doubt_category": false,
//"can_set_category": false,
//"post_type": "post",
//"text": "Это просто бомба! &#128163;",
//"marked_as_ads": 0,
//  "attachments": [{
//      "type": "video",
//      "video": {
//          "access_key": "1608fa0115e43294c4",
//          "can_comment": 0,
//          "can_like": 0,
//          "can_repost": 0,
//          "can_subscribe": 0,
//          "can_add_to_faves": 0,
//          "can_add": 0,
//          "date": 1620654046,
//          "description": "Это бомба! &#128163;",
//          "duration": 157,
//          "image": [{
//                "height": 96,
//                "url": "https://sun9-68.u...0f1/CFc-a6cQG9E.jpg",
//                "width": 130,
//                "with_padding": 1
//                }, {
//                "height": 120,
//                "url": "https://sun9-9.us...0f2/Em_apySY73U.jpg",
//                "width": 160,
//                "with_padding": 1
//                }, {
//                "height": 240,
//                "url": "https://sun9-15.u...0f3/hzJx9praUew.jpg",
//                "width": 320,
//                "with_padding": 1
//                }, {
//                "height": 450,
//                "url": "https://sun9-34.u...0f4/kNPh3vy_Kzw.jpg",
//                "width": 800,
//                "with_padding": 1
//                }],
//"id": 456239607,
//"owner_id": 476762144,
//"title": "Веном 2 – официальный трейлер",
//"is_favorite": false,
//"track_code": "video_4e9de2f0goH-PF5z_NEFCM0P7rDy2QEVDP06pKJrpLnfCR8o-WqypPw9N3f_0gIIyowSO3vpMiw6zQ2nxg7Suc8k",
//"type": "video",
//"views": 9523,
//"platform": "YouTube"
//}
//}],
//"post_source": {
//"type": "api"
//},
//"comments": {
//"count": 0,
//"can_post": 0
//},
//"likes": {
//"count": 5,
//"user_likes": 0,
//"can_like": 1,
//"can_publish": 1
//},
//"reposts": {
//"count": 6,
//"user_reposted": 0
//},
//"views": {
//"count": 2464
//},
//"is_favorite": false,
//"donut": {
//"is_donut": false
//},
//"short_text_rate": 0.8,
//"post_id": 351643,
//"type": "post"
//}],
//"profiles": [{
//"first_name": "Роман",
//"id": 476762144,
//"last_name": "Лис",
//"can_access_closed": false,
//"is_closed": true,
//"sex": 2,
//"screen_name": "id476762144",
//"photo_50": "https://vk.com/images/camera_50.png",
//"photo_100": "https://vk.com/images/camera_100.png",
//"online_info": {
//"visible": true,
//"last_seen": 1621367616,
//"is_online": true,
//"is_mobile": false
//},
//"online": 1
//}],
//"groups": [{
//"id": 30022666,
//"name": "Лепра",
//"screen_name": "leprum",
//"is_closed": 0,
//"type": "page",
//"is_admin": 0,
//"is_member": 1,
//"is_advertiser": 0,
//"photo_50": "https://sun9-52.u...2048,2048&ava=1",
//"photo_100": "https://sun9-52.u...2048,2048&ava=1",
//"photo_200": "https://sun9-52.u...2048,2048&ava=1"
//}],
//"next_from": "1/5_-30022666_351643:670016604"
//}
//}
struct Posts: Equatable {
    let header: String
    let mainPic: UIImage?
    let description: String?
    let bodyText: String?
    let date: Date?
    let pics: [UIImage?]
    let isLiked: Bool
    let isReposted: Bool
}



class Post: RealmSwift.Object {

    @objc dynamic var sourceId: Int = 0
    @objc dynamic var date: Date?
    @objc dynamic var text: String = ""
    @objc dynamic var commentsCount: Int = 0
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var repostsCount: Int = 0
    @objc dynamic var viewsCount: Int = 0
    //@objc dynamic var photoUrlString: String = ""
    
    //let photos = List<VKPhoto>()

    //var photoUrl: URL? { URL(string: photoUrlString) }

    convenience init(json: JSON) {
        self.init()

        self.sourceId = json["source_id"].intValue
        self.date = Date(timeIntervalSince1970: json["date"].doubleValue)
        self.text = json["text"].stringValue
        self.commentsCount = json["comments"]["count"].intValue
        self.likesCount = json["likes"]["count"].intValue
        self.repostsCount = json["reposts"]["count"].intValue
        self.viewsCount = json["views"]["count"].intValue
        //let commentsJSONArray = json["comments"].arrayValue
        //self.commentsCount = sizesJSONArray.map(Size.init)
        //self.photoUrlString = json["photo_100"].stringValue
    }
    
    override class func primaryKey() -> String? {
        return "sourceId"
    }
}
