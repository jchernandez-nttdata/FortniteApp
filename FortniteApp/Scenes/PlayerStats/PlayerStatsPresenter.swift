//
//  PlayerStatsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import Foundation


protocol PlayerStatsPresenterProtocol {
    func handleViewDidLoad()
    func handleBackButtonPressed()
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
        view.showLoading()
        Task {
            do {
                playerStats = try await interactor.getPlayerStats(accountId: accountId)
                view.dismissLoading()
                guard let playerStats else {
                    throw NetworkingError.requestFailed(statusCode: nil)
                }
                view.setupStats(stats: playerStats)
            } catch {
                view.dismissLoading()
                view.showError(title: "Something went wrong", description: "The player’s profile might be private or there was an error processing your request. Please try again later.")
            }
        }
        
    }
    
    func handleBackButtonPressed() {
        router.routePop()
    }
}
