//
//  RealmStorage.swift
//  ChargeMap
//
//  Created by Ilke Yucel on 09.03.2024.
//

import RealmSwift

final class RealmStorage {
    static let shared = RealmStorage()
    
    private let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func save<T: Object>(object: T) {
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print("Failed to save object: \(error)")
        }
    }
    
    func save<T: Object>(objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .all)
            }
        } catch {
            print("Failed to save objects: \(error)")
        }
    }
    
    func fetch<T: Object>(type: T.Type) -> Results<T> {
        realm.objects(type)
    }
    
    func delete<T: Object>(object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Failed to delete object: \(error)")
        }
    }
}
