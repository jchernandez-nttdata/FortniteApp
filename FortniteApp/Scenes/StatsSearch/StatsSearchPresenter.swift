//
//  StatsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol StatsSearchPresenterProtocol {
    var playerMatches: [PlayerSearchMatch] { get }
    var searchHistory: [PlayerSearchHistoryRecord] { get }
    
    func handleSearchQueryChanged(query: String)
    func handleDidSelectPlayer(at index: Int)
    func handleViewDidLoad()
}

final class StatsSearchPresenter {
    
    unowned var view: StatsSearchView!
    var interactor: StatsSearchInteractorProtocol!
    var router: StatsSearchRouterProtocol!
    
    internal var playerMatches: [PlayerSearchMatch] = []
    internal var searchHistory: [PlayerSearchHistoryRecord] = []
    
}

extension StatsSearchPresenter: StatsSearchPresenterProtocol {
    
    func handleSearchQueryChanged(query: String) {
        guard !query.isEmpty else {
            playerMatches = []
            view.reloadSearchTableView()
            toggleTablesVisibility(isHistoryHidden: false)
            return
        }
        
        view.showLoading()
        Task {
            do {
                playerMatches = try await interactor.searchPlayer(query: query)
                view.reloadSearchTableView()
                view.dismissLoading()
                toggleTablesVisibility(isHistoryHidden: true)
            } catch {
                //TODO: show error
                view.dismissLoading()
            }
        }
    }
    
    func handleDidSelectPlayer(at index: Int) {
        let player = playerMatches[index]
        let historyRecord = PlayerSearchHistoryRecord(
            name: player.matches.first?.value ?? "",
            platform: player.matches.first?.platform ?? "",
            accountId: player.accountId
        )
        do {
            try interactor.saveSearchHistoryRecord(object: historyRecord)
        } catch {
            // TODO: handle history save error
        }
        
        //TODO: navigate to player detail
    }
    
    func handleViewDidLoad() {
        do {
            searchHistory = try interactor.getSearchHistory().reversed()
            //TODO: handle empty case
            view.reloadHistoryTableView()
        } catch {
            // TODO: handle history get error
        }
    }
    
    private func toggleTablesVisibility(isHistoryHidden: Bool) {
        if (!isHistoryHidden) {
            handleViewDidLoad()
        }
        view.setHistoryTableViewVisibility(isHidden: isHistoryHidden)
        view.setSearchTableViewVisibility(isHidden: !isHistoryHidden)
    }
}
