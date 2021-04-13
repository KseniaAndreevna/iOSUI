//
//  NetworkService.swift
//  VKApp
//
//  Created by Ksenia Volkova on 27.03.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class NetworkService {
    
    let baseVkUrl = "https://api.vk.com"
    private let accessToken: String
    
    var baseParams: Parameters {
        [
            "access_token": accessToken,
            "extended": 1,
            "v": "5.92"
        ]
    }
    
    init(token: String) {
        self.accessToken = token
    }
    
    func loadGroups(completionHandler: @escaping ((Result<[Group], Error>) -> Void)) {
        let path = "/method/groups.get"
    
        AF.request(baseVkUrl + path, method: .get, parameters: baseParams).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                    let groups = groupsResponse.response.items
                    completionHandler(.success(groups))
                } catch {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func loadFriends(completionHandler: @escaping ((Result<[User], Error>) -> Void)) {
        let path = "/method/friends.get"
        
//        fields список дополнительных полей, которые необходимо вернуть.
//        Доступные значения: nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities
        var params = baseParams
        params["fields"] = [ "photo_100" ]
        
        AF.request(baseVkUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case let .failure(error):
                completionHandler(.failure(error))
            case let .success(json):
                //            {
                //              "response" : {
                //                "count" : 322,
                //                "items" : [
                //                  {
                //                    "id" : 6949,
                let friendsJSONArray = JSON(json)["response"]["items"].arrayValue
                let friends = friendsJSONArray.map(User.init)
                completionHandler(.success(friends))
            }
        }
    }
    
    func searchGroup(group: String, completionHandler: @escaping ((Result<[Group], Error>) -> Void)) {
        let path = "/method/groups.search"
        var params = baseParams
        params["q"] = group
        
        print("group \(group)")
        
        AF.request(baseVkUrl + path, method: .get, parameters: params).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                    let groups = groupsResponse.response.items
                    completionHandler(.success(groups))
                } catch {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
   }
    
    func loadPics(token: String) {
        //photos.getUserPhotos
        let path = "/method/photos.getUserPhotos"
        
        AF.request(baseVkUrl + path, method: .get, parameters: baseParams).responseJSON { response in
            guard let json = response.value else { return }
            
            print("jsonPics \(json)")
        }
    }
    
    func saveUserData(_ users: [User]) {
        guard let realm = try? Realm() else { return }
        guard let user = realm.objects(User.self).first else { return }
        print(#function)
        print(user.firstName)
    }
    
//    func saveUserData(_ users: [User]) {
//        do {
//            let realm = try Realm()
//            realm.beginWrite()
//            realm.add(users)
//            try realm.commitWrite()
//        } catch {
//            print(error)
//        }
//
//        let path = "/method/friends.get"
//
//        AF.request(baseVkUrl + path, method: .get, parameters: baseParams).responseData { [weak self] response in
//
//            guard let data = response.value else { return }
//            let user = try! JSONDecoder().decode(UserResponse.self, from: data).list
//            self?.saveUserData(users)
//        }
//
//        guard let realm = try? Realm() else { return }
//        let userDB = User(id: users.first?.id, firstName: users.first?.firstName, lastName:  users.first?.lastName)
//            //User(id: 123456789, firstName: "Oleg", lastName: "Olegov")
//        //, photoUrl: try! "https://sun9-31.userapi.com/impf/c633822/v633822902/cbbc/WiUU02CBWnc.jpg?size=510x510&quality=96&sign=c95b2e6aef204a68280a503c252d082d&c_uniq_tag=g6sThugClKRET9e8v6BLNKo_l78wvEPWVa4_muhoUwM&type=album".asURL() //
//        try? realm.write {
//            realm.add(userDB)
//        }
//    }

    func loadUserData () {
        guard let realm = try? Realm() else { return }
        let user = [User(id: 123456789, firstName: "Test", lastName: "Test")
                         //, photoUrl: try! "".asURL()),
        ]
        try? realm.write {
            realm.add(user)
        }
        print(#function)
        //print(user.firstName)
    }

}
