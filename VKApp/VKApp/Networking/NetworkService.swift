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
import PromiseKit

class NetworkService {
    
    let baseVkUrl = "https://api.vk.com"
    private let accessToken: String
    
    var baseParams: Parameters {
        [
            "access_token": accessToken,
            "extended": 1,
            "v": "5.126"
        ]
    }
    
    var filterParams: Parameters { [
        "access_token": accessToken,
        "v": "5.126",
        "filters": "post",
        "count": 20
     ]
    }
    
    init(token: String) {
        self.accessToken = token
    }
    
    func loadGroups(completionHandler: @escaping ((Swift.Result<[Group], Error>) -> Void)) {
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
    
    func loadFriends() -> Promise<[User]> {
        let path = "/method/friends.get"
        
//        fields список дополнительных полей, которые необходимо вернуть.
//        Доступные значения: nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities
        var params = baseParams
        params["fields"] = [ "photo_100" ]
        
        return Promise.init { resolver in
            AF.request(baseVkUrl + path, method: .get, parameters: params).responseJSON { response in
                switch response.result {
                case let .failure(error):
                    resolver.reject(error)
//                    completionHandler(.failure(error))
                case let .success(json):
                    //            {
                    //              "response" : {
                    //                "count" : 322,
                    //                "items" : [
                    //                  {
                    //                    "id" : 6949,
                    let friendsJSONArray = JSON(json)["response"]["items"].arrayValue
                    let friends = friendsJSONArray.map(User.init)
                    resolver.fulfill(friends)
//                    completionHandler(.success(friends))
    //                print("loadFriends \(friends)")
                }
            }
        }
    }
    
    func searchGroup(group: String, completionHandler: @escaping ((Swift.Result<[Group], Error>) -> Void)) {
        let path = "/method/groups.search"
        var params = baseParams
        params["q"] = group
//        print("group \(group)")
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
    
//    func searchFriend(friend: String, completionHandler: @escaping ((Result<[User], Error>) -> Void)) {
//        let path = "/method/friends.search"
//        var params = baseParams
//        params["q"] = friend
////        print("friend \(friend)")
//        AF.request(baseVkUrl + path, method: .get, parameters: params).responseData { response in
//            switch response.result {
//            case let .success(json):
//                do {
//                    let friendsJSONArray = JSON(json)["response"]["items"].arrayValue
//                    let friends = friendsJSONArray.map(User.init)
//                    completionHandler(.success(friends))
//                } catch {
//                    completionHandler(.failure(error))
//                }
//            case let .failure(error):
//                completionHandler(.failure(error))
//            }
//        }
//   }
    
    func loadPics(token: String) {
        let path = "/method/photos.getUserPhotos"
        
        AF.request(baseVkUrl + path, method: .get, parameters: baseParams).responseJSON { response in
            guard let json = response.value else { return }
            print("jsonPics \(json)")
        }
    }

    func saveUserData(_: User) {
        guard let realm = try? Realm() else { return }
        guard let user = realm.objects(User.self).first else { return }
        print("saveUserData \(user.firstName)")
    }
    
    func loadUserData (_: User) {
        guard let realm = try? Realm() else { return }
        let user = User()
        try? realm.write {
            realm.add(user)
        }
        print(#function + "\(user.photoUrlString)")
    }
    
    
    func loadPhotos(owner: Int, completionHandler: @escaping ((Swift.Result<[VKPhoto], Error>) -> Void)) {
        let path = "/method/photos.get"
        var photoParams = baseParams
        photoParams["extended"] = 0
        photoParams["owner_id"] = owner
        photoParams["album_id"] = "wall"
        photoParams["photo_sizes"] = 1
        
        AF.request(baseVkUrl + path, method: .get, parameters: photoParams).responseJSON { response in
            switch response.result {
            case let .failure(error):
                completionHandler(.failure(error))
            case let .success(json):
//                var count = JSON(json)["response"]["count"].intValue
                
                let photosJSONArray = JSON(json)["response"]["items"].arrayValue
                
                
                let photosFriend = photosJSONArray.map(VKPhoto.init)
//                if count > 50 {
//                    count = 50
//                }
//                for index in 0..<count {
//                    let photoSizeJSONArray = JSON(json)["response"]["items"][index]["sizes"].arrayValue
//                    let photoSizeArray = photoSizeJSONArray.map(VKPhotoSize.init)
////                    photosFriend[index].sizes = photoSizeArray
////                    photosFriend[index].count = count
//
//                }
                completionHandler(.success(photosFriend))
            }
        }
        
        print(#function + "\(owner)")
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
    
    
    func friend(for lastName: String = "Попов", completion: @escaping (Swift.Result<[User], Error>) -> Void) {

        let path = "/method/friends.search"
        var params = baseParams
        params["q"] = lastName

        print("lastName \(lastName)")

        AF.request(baseVkUrl + path, method: .get, parameters: params).response { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
                //completionHandler(.failure(error))
            case .success(let data):
                guard let data = data,
                      let json = try? JSON(data: data) else { return }

                let friendsJSON = json["list"].arrayValue
                //let friends = friendsJSON.map { User(json: $0, lastName: lastName) }
                let friends = friendsJSON.map { User(json: $0) }

                completion(.success(friends))
            }
        }
    }
    
    typealias NextFromAnchor = String
    
    //func loadNews(completionHandler: @escaping ((Swift.Result<[News], Error>) -> Void)) {
    func loadNews(startTime: Date? = nil, nextFrom: String? = nil, completion: @escaping ([News], NextFromAnchor) -> Void) {
        let path = "/method/newsfeed.get"
        
        var params = filterParams
        
        if let startTime = startTime {
            params["start_time"] = String(startTime.timeIntervalSince1970 + 1)
        }
        if let nextFrom = nextFrom {
            params["start_from"] = nextFrom
        }
    
        AF.request(baseVkUrl + path, method: .get, parameters: filterParams).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case let .success(json):
                
                let dispatchGroup = DispatchGroup()
                
                var news: [News] = []
                var users: [User] = []
                var groups: [Group] = []
                //let json = JSON(data)
                let nextFromAnchor = JSON(json)["response"]["next_from"].stringValue
                
                DispatchQueue.global().async(group: dispatchGroup, qos: .userInitiated) {
                    let newsJSONArray = JSON(json)["response"]["items"].arrayValue
                    //news = newsJSONArray.map(News.init)
                    news = newsJSONArray.compactMap { News(json: $0 ) }
                    //try? RealmService.save(items: news)
                }
                
                DispatchQueue.global().async(group: dispatchGroup, qos: .userInitiated) {
                    let usersJSONArray = JSON(json)["response"]["profiles"].arrayValue
                    //users = usersJSONArray.map { User(json: $0 ) }
                    users = usersJSONArray.compactMap { User(json: $0 ) }
                    try? RealmService.save(items: users, configuration: RealmService.deleteIfMigration, update: .modified)
                }

                DispatchQueue.global().async(group: dispatchGroup, qos: .userInitiated) {
                    let groupsJSONArray = JSON(json)["response"]["groups"]
                    groups = try! JSONDecoder().decode([Group].self, from: try! groupsJSONArray.rawData())
                    try? RealmService.save(items: groups, configuration: RealmService.deleteIfMigration, update: .modified)
                }
                
                dispatchGroup.notify(queue: DispatchQueue.global()) {
                    let newsWithSources = news.compactMap { news -> News? in
                        if news.sourceId > 0 {
                            var newsCopy = news
                            guard let newsSource = users.first(where: { $0.id == news.sourceId }) else { return nil }
                            newsCopy.source = newsSource
                            return newsCopy
                        } else {
                            var newsCopy = news
                            guard let newsSource = groups.first(where: { -$0.groupId == news.sourceId }) else { return nil }
                            newsCopy.source = newsSource
                            return newsCopy
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(newsWithSources, nextFromAnchor)
                    }

                }
            }
        }
    }
    
    func loadPosts(completionHandler: @escaping ((Swift.Result<[Post], Error>) -> Void)) {
        let path = "/method/newsfeed.get"
    
        AF.request(baseVkUrl + path, method: .get, parameters: baseParams).responseJSON { response in
            switch response.result {
            case let .failure(error):
                completionHandler(.failure(error))
            case let .success(json):
                let postsJSONArray = JSON(json)["response"]["items"].arrayValue
                let posts = postsJSONArray.map(Post.init)
                completionHandler(.success(posts))
//                print("loadPosts \(posts)")

            }
        }
    }

}
