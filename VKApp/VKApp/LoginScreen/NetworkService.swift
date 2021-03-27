//
//  NetworkService.swift
//  VKApp
//
//  Created by Ksenia Volkova on 27.03.2021.
//

import Foundation
import Alamofire

class NetworkService {
    
    func loadGroups(token: String) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92"
        ]
        
        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            Session.shared.groupsJSON = json as? JSONEncoder
            print("jsonGroups \(json)")
        }
    }
    
    func loadFriends(token: String) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92"
        ]
        
        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            Session.shared.friendsJSON = json as? JSONEncoder
            print("jsonFriends \(json)")
        }
    }
    
//    func findGroup(with name: String) {
//
//        var groupID: String = ""
//        var groupName: String = Session.shared.friendsJSON["name"] as! String
//
//        print("Find in jsonGroups with name \(groupName) is \(groupID)")
//    }
    
    func loadPics(token: String) {
        //photos.getUserPhotos
        let baseUrl = "https://api.vk.com"
        let path = "/method/photos.getUserPhotos"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.92"
        ]
        
        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            Session.shared.picsJSON = json as? JSONEncoder
            print("jsonPics \(json)")
        }
    }
}
