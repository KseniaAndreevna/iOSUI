//
//  Group.swift
//  VKApp
//
//  Created by Ksusha on 24.02.2021.
//

import UIKit

struct Group: Equatable {
    let groupId: Int
    let name: String
    let description: String?
    //let openDate: Date?
    let mainPic: UIImage?
    let pics: [UIImage?]
}

