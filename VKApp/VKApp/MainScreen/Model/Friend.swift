//
//  User.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit

struct Friend: Equatable {
    let userId: Int
    let firstName: String
    let surname: String
    //let birthday: Date?
    let avatar: UIImage?
    let pics: [UIImage?]
}

struct FriendSection: Comparable {
    let title: Character
    let friends: [Friend]
    
    static func < (lhs: FriendSection, rhs: FriendSection) -> Bool {
        lhs.title < rhs.title
    }
}
