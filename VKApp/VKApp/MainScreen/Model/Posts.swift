//
//  Posts.swift
//  VKApp
//
//  Created by Ksenia Volkova on 09.05.2021.
//

import UIKit

struct Posts: Equatable {
    let header: String
    let mainPic: UIImage?
    let description: String?
    let bodyText: String?
    let date: Date?
    let pics: [UIImage?]
    let isLiked: Bool
    let isReposted: Bool
}
