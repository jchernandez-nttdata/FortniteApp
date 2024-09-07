//
//  StatsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol StatsSearchPresenterProtocol {
    var playerMatches: [PlayerSearchMatch] { get }
    
    func handleSearchQueryChanged(query: String)
}

final class StatsSearchPresenter {
    
    unowned var view: StatsSearchView!
    var interactor: StatsSearchInteractorProtocol!
    var router: StatsSearchRouterProtocol!
    
    internal var playerMatches: [PlayerSearchMatch] = []
    
}

extension StatsSearchPresenter: StatsSearchPresenterProtocol {
    func handleSearchQueryChanged(query: String) {
        guard !query.isEmpty else {
            playerMatches = []
            view.reloadSearchTableView()
            return
        }
        
        view.showLoading()
        Task {
            do {
                playerMatches = try await interactor.searchPlayer(query: query)
                view.reloadSearchTableView()
                view.dismissLoading()
            } catch {
                //TODO: show error
                view.dismissLoading()
            }
        }
    }
    
    
}
