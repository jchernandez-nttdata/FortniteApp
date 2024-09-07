//
//  SearchHistoryRepository.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 7/09/24.
//

import Foundation

/// Repository protocol resposible for retreiving search history
protocol SearchHistoryRepositoryProtocol {
    
    /// Retrieves the list of search history records.
    /// - Returns: An array of `PlayerSearchHistoryRecord` objects representing the search history.
    /// - Throws: An error if the retrieval fails.
    func getSearchHistory() throws -> [PlayerSearchHistoryRecord]
    
    /// Saves a new search history record.
    /// - Parameter object: The `PlayerSearchHistoryRecord` object to be saved.
    /// - Throws: An error if the save operation fails.
    func saveSearchHistoryRecord(object: PlayerSearchHistoryRecord) throws
    
    /// Deletes a specific search history record.
    /// - Parameter object: The `PlayerSearchHistoryRecord` object to be deleted.
    /// - Throws: An error if the delete operation fails.
    func deleteSearchHistoryRecord(object: PlayerSearchHistoryRecord) throws
}

/// Implementation of the `SearchHistoryRepositoryProtocol` for managing search history records from local database
final class SearchHistoryRepository: SearchHistoryRepositoryProtocol {
    
    private let localDataManager: LocalDataManagerProtocol
    
    init(localDataManager: LocalDataManagerProtocol = RealmLocalDataManager()) {
        self.localDataManager = localDataManager
    }
    
    /// Retrieves the list of search history records.
    /// - Returns: An array of `PlayerSearchHistoryRecord` objects representing the search history.
    /// - Throws: An error if the retrieval fails.
    func getSearchHistory() throws -> [PlayerSearchHistoryRecord] {
        return try localDataManager.fetch(PlayerSearchHistoryRecord.self)
    }
    
    /// Saves a new search history record.
    /// - Parameter object: The `PlayerSearchHistoryRecord` object to be saved.
    /// - Throws: An error if the save operation fails.
    func saveSearchHistoryRecord(object: PlayerSearchHistoryRecord) throws {
        
        let history = try localDataManager.fetch(PlayerSearchHistoryRecord.self)
        
        // checks if the accountId already exists in search history
        let filteredHistory = history.filter { record in
            record.accountId == object.accountId
        }
        
        guard filteredHistory.isEmpty else {
            return
        }
        
        try localDataManager.save(object)
    }
    
    /// Deletes a specific search history record.
    /// - Parameter object: The `PlayerSearchHistoryRecord` object to be deleted.
    /// - Throws: An error if the delete operation fails.
    func deleteSearchHistoryRecord(object: PlayerSearchHistoryRecord) throws {
        try localDataManager.delete(object)
    }
    
}
