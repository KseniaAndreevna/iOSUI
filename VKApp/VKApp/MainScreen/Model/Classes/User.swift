//
//  User.swift
//  VKApp
//
//  Created by Ksenia Volkova on 03.04.2021.
//

import UIKit
import SwiftyJSON

class User: Decodable {
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
