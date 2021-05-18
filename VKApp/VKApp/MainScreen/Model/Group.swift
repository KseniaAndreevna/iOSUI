//
//  Group.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit
import RealmSwift

struct GroupResponse: Codable {
    let response: GroupContainer
}

struct GroupContainer: Codable {
    let items: [Group]
}

//"response" : {
//  "count" : 54,
//  "items" : [
//    {
//      "photo_100" : "https:\/\/sun1-99.userapi.com\/s\/v1\/ig2\/1lFnEus_1kGNxyNFaPUAYPv4rFKxv79w1-RYHUbQkeohd4yWPft6bzsn9MNvHz4HAH90KAgsT0mxgbywyEGmc0fM.jpg?size=100x0&quality=96&crop=6,5,1098,1098&ava=1",
//      "is_admin" : 0,
//      "photo_50" : "https:\/\/sun1-99.userapi.com\/s\/v1\/ig2\/7Ho8olI_mGOcSvABi7aVboqRy33AS4pT7qbp325XoSD3C_tml4CMq_uC-OnA8vOIHFZhUc7MYuDVIfmuK6P6ZQE3.jpg?size=50x0&quality=96&crop=6,5,1098,1098&ava=1",
//      "screen_name" : "lentach",
//      "id" : 29534144,
//      "type" : "page",
//      "is_closed" : 0,
//      "is_advertiser" : 0,
//      "name" : "Лентач",
//      "is_member" : 1,
//      "photo_200" : "https:\/\/sun1-99.userapi.com\/s\/v1\/ig2\/xtJFBRPa19Qj6riYjU6axByE-uRprP6w6HLZ3LxUsYCzJSzBfp0tN-jk6Ne_jyyLKMfTndDFTQeb9hyUCiwFzYxL.jpg?size=200x0&quality=96&crop=6,5,1098,1098&ava=1"
//    },

class Group: Object, Codable {
    @objc dynamic var groupId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic private var pictureUrlString: String = ""
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groupId = try container.decode(Int.self, forKey: .groupId)
        name = try container.decode(String.self, forKey: .name)
        pictureUrlString = try container.decode(String.self, forKey: .pictureUrlString)
    }
    
    var pictureUrl: URL? { URL(string: pictureUrlString) }
    
    enum CodingKeys: String, CodingKey {
        case groupId = "id"
        case name
        case pictureUrlString = "photo_200"
    }
    
    override class func primaryKey() -> String? {
        return "groupId"
    }
}











struct GroupSection: Comparable {
    let title: Character
    let groups: [Group]
    
    static func < (lhs: GroupSection, rhs: GroupSection) -> Bool {
        lhs.title < rhs.title
    }
}

struct GroupPic: Equatable {
    let name: String
    let date: Date
    let pic: UIImage
}


