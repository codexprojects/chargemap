//
//  RealmStorage.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import RealmSwift

enum LocalDatabaseError: Error {
    case failedToSave
    case failedToFetch
}

final class RealmStorage {
    static let shared = RealmStorage()
    
    private init() {}
    
    private func getRealm() throws -> Realm {
        return try Realm()
    }
    
    func save<T: Object>(object: T) {
        do {
            let realm = try getRealm()
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print("Failed to save object: \(error)")
        }
    }
    
    func save<T: Object>(objects: [T]) throws {
        let realm = try getRealm()
        try realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func fetch<T: Object>(type: T.Type) throws -> Results<T> {
        let realm = try getRealm()
        return realm.objects(type)
    }
    
}
