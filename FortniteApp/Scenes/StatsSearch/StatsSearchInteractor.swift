//
//  StatsInteractor.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol StatsSearchInteractorProtocol {
    func searchPlayer(query: String) async throws -> [PlayerSearchMatch]
    func getSearchHistory() throws -> [PlayerSearchHistoryRecord]
    func saveSearchHistoryRecord(object: PlayerSearchHistoryRecord) throws
    func deleteSearchHistoryRecord(object: PlayerSearchHistoryRecord) throws
}

final class StatsSearchInteractor {
    private let statsRepository: StatsRepositoryProtocol
    private let searchHistoryRepository: SearchHistoryRepositoryProtocol
    
    init(
        statsRepository: StatsRepositoryProtocol = StatsRepository(),
        searchHistoryRepository: SearchHistoryRepositoryProtocol = SearchHistoryRepository()
    ) {
        self.statsRepository = statsRepository
        self.searchHistoryRepository = searchHistoryRepository
    }
}

extension StatsSearchInteractor: StatsSearchInteractorProtocol {
    func searchPlayer(query: String) async throws -> [PlayerSearchMatch] {
        return try await statsRepository.searchPlayer(query: query)
    }
    
    func getSearchHistory() throws -> [PlayerSearchHistoryRecord] {
        return try searchHistoryRepository.getSearchHistory()
    }
    
    func saveSearchHistoryRecord(object: PlayerSearchHistoryRecord) throws {
        try searchHistoryRepository.saveSearchHistoryRecord(object: object)
    }
    
    func deleteSearchHistoryRecord(object: PlayerSearchHistoryRecord) throws {
        try searchHistoryRepository.deleteSearchHistoryRecord(object: object)
    }
    
}
