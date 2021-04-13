//
//  User.swift
//  VKApp
//
//  Created by Ksenia Volkova on 03.04.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift


//{
//  "response" : {
//    "count" : 322,
//    "items" : [
//      {
//        "id" : 6949,
//        "deactivated" : "deleted",
//        "photo_100" : "https:\/\/vk.com\/images\/deactivated_100.png",
//        "track_code" : "ad6c086aFta1Uqg77G4Fqx9cxlIPqn-uHUte-kvJ4DqrKFZ2QJV7veprnT3tag_PcsVTgeDdbcg",
//        "first_name" : "Александр",
//        "last_name" : "Мишенин"
//      },
//      {
//        "id" : 14403,
//        "photo_100" : "https:\/\/sun1-29.userapi.com\/s\/v1\/if1\/f2EK3X_wP8JcqHanigdypv7YWfPgb6jeJTGujtg5LqGU6zm9ZR7DK3Xj9_Z4aOBes2L8iwh4.jpg?size=100x0&quality=96&crop=0,251,1538,1538&ava=1",
//        "track_code" : "27bf8006syEhdFQHYTS7IM4mKOwo_VHQ1L36oB-FhTz70Oa8_tveSnIXaAZjML1wybOuJsmdMbam",
//        "last_name" : "Zak",
//        "can_access_closed" : true,
//        "is_closed" : false,
//        "first_name" : "Dmitry"
//      },




class User: RealmSwift.Object {
    
    @objc dynamic var id: Int = 0
    //private var photoUrlString: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""

    //@objc dynamic var photoUrl: URL? { URL(string: photoUrlString) }
    
    convenience init(id: Int, firstName: String, lastName: String//, photoUrl: URL
    ) {
        self.init()

        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        //self.photoUrlString = photoUrlString
    }
}




class JSONUser {
    var id: Int = 0
    private var photoUrlString: String = ""
    var firstName: String = ""
    var lastName: String = ""
    
    var photoUrl: URL? { URL(string: photoUrlString) }
     
    init(json: JSON) {
        self.id = json["id"].intValue
        self.photoUrlString = json["photo_100"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
    }
}

struct UserSection: Comparable {
    let title: Character
    let friends: [User]
    
    static func < (lhs: UserSection, rhs: UserSection) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: UserSection, rhs: UserSection) -> Bool {
        lhs.title == rhs.title
    }
}














class OldUser: Decodable {
    var userId: Int = 0
    var firstName: String = ""
    var surname: String = ""
    var birthday: Date? = nil
    var avatar: UIImage? = nil
    var pics: [UIImage?] = []
    
    enum CodingKeys: String, CodingKey {
        case birthday = "dt"
        case main
        case user
        case name
    }
    
    enum MainKeys: String, CodingKey {
        case userId
        case firstName
        case surname
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.birthday = try values.decode(Date.self, forKey: .birthday)
            
        let mainValues = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        self.userId = try mainValues.decode(Int.self, forKey: .userId)
        self.firstName = try mainValues.decode(String.self, forKey: .firstName)
        self.surname = try mainValues.decode(String.self, forKey: .surname)
    }
    
//    init(json: SwiftyJSON.JSON) {
//        self.birthday = Date(timeIntervalSince1970: json["dt"].doubleValue)
//        self.userId = json["main"]["userId"].intValue
//        let userJson = json["user"].arrayValue.first
//        self.avatar = firstWeatherJson?["icon"].stringValue ?? ""
//    }
}
