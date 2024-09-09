//
//  PlayerStatsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import Foundation


protocol PlayerStatsPresenterProtocol {
    func handleViewDidLoad()
}

final class PlayerStatsPresenter {
    unowned var view: PlayerStatsView!
    var router: PlayerStatsRouterProtocol!
    var interactor: PlayerStatsInteractorProtocol!
    
    let accountId: String
    private var playerStats: PlayerStats?
    
    init(accountId: String) {
        self.accountId = accountId
    }
}

extension PlayerStatsPresenter: PlayerStatsPresenterProtocol {
    func handleViewDidLoad() {
        Task {
            do {
                playerStats = try await interactor.getPlayerStats(accountId: accountId)
                guard let playerStats else {
                    throw NetworkingError.requestFailed(statusCode: nil)
                }
                view.setupStats(stats: playerStats)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
}
