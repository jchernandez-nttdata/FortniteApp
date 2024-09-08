//
//  PlayerStatsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import Foundation


protocol PlayerStatsPresenterProtocol {
    
}

final class PlayerStatsPresenter {
    unowned var view: PlayerStatsView!
    var router: PlayerStatsRouterProtocol!
    var interactor: PlayerStatsInteractorProtocol!
    
    let accountId: String
    
    init(accountId: String) {
        self.accountId = accountId
    }
}

extension PlayerStatsPresenter: PlayerStatsPresenterProtocol {
    
}
