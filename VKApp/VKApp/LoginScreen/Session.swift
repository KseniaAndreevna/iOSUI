//
//  Session.swift
//  VKApp
//
//  Created by Ksenia Volkova on 21.03.2021.
//

import Foundation

class Session {
    public static let shared = Session()
    
    private init(){}
    
    var token: String = ""
    var userId: String = ""
    
    var friendsJSON: JSONEncoder? = nil
    var groupsJSON: JSONEncoder? = nil
    var picsJSON: JSONEncoder? = nil
}
