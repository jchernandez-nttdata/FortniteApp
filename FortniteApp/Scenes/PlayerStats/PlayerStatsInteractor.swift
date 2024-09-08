//
//  PlayerStatsInteractor.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import Foundation

protocol PlayerStatsInteractorProtocol {
    func getPlayerStats(accountId: String) async throws -> PlayerStats
}

final class PlayerStatsInteractor {
    private let statsRepository: StatsRepositoryProtocol
    
    init(statsRepository: StatsRepositoryProtocol = StatsRepository()) {
        self.statsRepository = statsRepository
    }
    
}


extension PlayerStatsInteractor: PlayerStatsInteractorProtocol {
    func getPlayerStats(accountId: String) async throws -> PlayerStats {
        return try await statsRepository.getPlayerStats(accountId: accountId)
    }
    
    
}
