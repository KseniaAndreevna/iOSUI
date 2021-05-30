//
//  RealmService.swift
//  VKApp
//
//  Created by Ksenia Volkova on 17.04.2021.
//

import Foundation
import RealmSwift

class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
    
    static func save<T: Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items)
        }
    }
    
    static func get<T: Object>(
        type: T.Type,
        configuration: Realm.Configuration = deleteIfMigration
    ) throws -> Results<T> {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        return realm.objects(T.self)
    }
}
