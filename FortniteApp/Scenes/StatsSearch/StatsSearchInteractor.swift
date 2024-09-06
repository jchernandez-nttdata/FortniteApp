//
//  StatsInteractor.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol StatsSearchInteractorProtocol {
    func searchPlayer(query: String) async throws -> [PlayerSearchMatch]
}

final class StatsSearchInteractor {
    private let statsRepository: StatsRepositoryProtocol
    
    init(statsRepository: StatsRepositoryProtocol = StatsRepository()) {
        self.statsRepository = statsRepository
    }
}

extension StatsSearchInteractor: StatsSearchInteractorProtocol {
    func searchPlayer(query: String) async throws -> [PlayerSearchMatch] {
        return try await statsRepository.searchPlayer(query: query)
    }
    
    
}
