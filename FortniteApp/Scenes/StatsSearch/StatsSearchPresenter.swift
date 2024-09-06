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
        // TODO: handle search load
        Task {
            do {
                playerMatches = try await interactor.searchPlayer(query: query)
                view.reloadSearchTableView()
            } catch {
                //TODO: show error
            }
        }
    }
    
    
}
