//
//  User.swift
//  VKApp
//
//  Created by Ksenia Volkova on 03.04.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

//struct FriendResponse: ObjectProvider {
//    let response: FriendContainer
//    
//    func getRealmObjects() -> [Object] {
//        return response.items
//    }
//}
//
//struct FriendContainer: Object {
//    let items: [User]
//}

class User: RealmSwift.Object, NewsSource {
    //MARK: - Protocol conformance
    var name: String { "\(firstName) \(lastName)" }
    var imageUrlString: String { photoUrlString }
    
    var url: String {
            return "https://www.moscowzoo.ru/upload/iblock/cee/cee90dfb0b7d31941283e835109a62b5.jpg"//"https://images.app.goo.gl/gBkUCDXdwVatheHX9"
        }
    
    //MARK: - Properties
    @objc dynamic var id: Int = 0
    @objc dynamic var photoUrlString: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    
    let photos = List<VKPhoto>()

    var photoUrl: URL? { URL(string: photoUrlString) }

    convenience init(json: JSON) {
        self.init()

        self.id = json["id"].intValue
        self.photoUrlString = json["photo_100"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
    }
    
    override class func primaryKey() -> String? {
        return "id"
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
