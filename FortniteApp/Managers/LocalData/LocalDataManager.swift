//
//  LocalDataManager.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/24.
//

import Foundation
import RealmSwift

protocol LocalDataManagerProtocol {
    
    /// Fetches data of the specified type from the local database.
    /// - Parameter type: The type of the data to fetch.
    /// - Returns: An array of data  type `T`.
    /// - Throws: An error if the fetching fails.
    func fetch<T: Object>(_ type: T.Type) throws -> [T]
    
    /// Saves an object of the specified type to the local database.
    /// - Parameter object: The object to save.
    /// - Throws: An error if the saving process fails.
    func save<T: Object>(_ object: T) throws
    
    /// Deletes an object of the specified type from the local database.
    /// - Parameter object: The object to delete.
    /// - Throws: An error if the deletion process fails.
    func delete<T: Object>(_ object: T) throws
}

final class RealmLocalDataManager: LocalDataManagerProtocol {
    
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func fetch<T: Object>(_ type: T.Type) throws -> [T] {
        let results = realm.objects(type)
        return Array(results)
    }
    
    func save<T: Object>(_ object: T) throws {
        try realm.write {
            realm.add(object)
        }
    }
    
    func delete<T: Object>(_ object: T) throws {
        try realm.write {
            realm.delete(object)
        }
    }
}
