//
//  NetworkService.swift
//  VKApp
//
//  Created by Ksenia Volkova on 27.03.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    
    let baseVkUrl = "https://api.vk.com"
    let paramsVk: Parameters = [
        "access_token": Session.shared.token,
        "extended": 1,
        "v": "5.92"
    ]
    
//    func loadGroups(token: String) {
//        let path = "/method/groups.get"
//
//        AF.request(baseVkUrl + path, method: .get, parameters: paramsVk).responseJSON { response in
//            guard let json = response.value else { return }
//
//            Session.shared.groupsJSON = json as? JSONEncoder
//            print("jsonGroups \(json)")
//        }
//    }
    
    func loadGroups(token: String) {
        let path = "/method/groups.get"
    
        AF.request(baseVkUrl + path, method: .get, parameters: paramsVk).responseData { response in
            //guard let data = response.value else { return }
            //let json = JSON(data: data)
            //let json = try! JSON(data: data); else do { return }
            
            guard let data = response.value,
                  let json = try? JSON(data: data) else { return }
                
            let user = try! JSONDecoder().decode(UserResponse.self, from: data).list
            print(json)
            print(user)
        }
    }
    
    func loadFriends(token: String) {
        let path = "/method/friends.get"
        
        AF.request(baseVkUrl + path, method: .get, parameters: paramsVk).responseJSON { response in
            guard let json = response.value else { return }
            
            Session.shared.friendsJSON = json as? JSONEncoder
            print("jsonFriends \(json)")
        }
    }
    
    func searchGroup(token: String, group: String) {
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92",
            "q": group
        ]
        
        print("group \(group)")
        
        AF.request(baseVkUrl + path, method: .get, parameters: params).responseJSON { response in
            //guard let json = response.value else { return }
            switch response.result {
            case .failure(let error):
                print("jsonSearchGroups \(error)")
            case .success(let json):
                print("jsonSearchGroups \(json)")
            }
        }
   }
    
    func loadPics(token: String) {
        //photos.getUserPhotos
        let path = "/method/photos.getUserPhotos"
        
        AF.request(baseVkUrl + path, method: .get, parameters: paramsVk).responseJSON { response in
            guard let json = response.value else { return }
            
            Session.shared.picsJSON = json as? JSONEncoder
            print("jsonPics \(json)")
        }
    }
}
