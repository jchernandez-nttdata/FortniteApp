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
    var isHistoryActive: Bool { get }
    
    func handleSearchQueryChanged(query: String)
    func handleDidSelectPlayer(at index: Int)
    func loadSearchHistory()
    func handleDeleteHistoryRecord(at index: Int)
}

final class StatsSearchPresenter {
    
    unowned var view: StatsSearchView!
    var interactor: StatsSearchInteractorProtocol!
    var router: StatsSearchRouterProtocol!
    
    var playerMatches: [PlayerSearchMatch] = []
    var searchHistory: [PlayerSearchHistoryRecord] = []
    var isHistoryActive: Bool = true
    
}

extension StatsSearchPresenter: StatsSearchPresenterProtocol {
    
    func handleSearchQueryChanged(query: String) {
        view.hideError()
        
        // show history if query is empty
        guard !query.isEmpty else {
            playerMatches = []
            isHistoryActive = true
            loadSearchHistory()
            return
        }
        
        view.showLoading()
        isHistoryActive = false
        Task {
            do {
                playerMatches = try await interactor.searchPlayer(query: query)
                if playerMatches.isEmpty {
                    view.dismissLoading()
                    view.showError(title: "No results", description: "Sorry, no results were found for your search. Please try searching for a different player.")
                    return
                }
                view.reloadTable()
                view.dismissLoading()
            } catch {
                view.showError(title: "Something went wrong", description: "An error occurred while searching players from the server. Please try again later.")
                view.dismissLoading()
            }
        }
    }
    
    func handleDidSelectPlayer(at index: Int) {
        
        if !isHistoryActive {
            let player = playerMatches[index]
            let historyRecord = PlayerSearchHistoryRecord(
                name: player.matches.first?.value ?? "",
                platform: player.matches.first?.platform ?? "",
                accountId: player.accountId
            )
            do {
                try interactor.saveSearchHistoryRecord(object: historyRecord)
            } catch {
                print("Failed to save history record \(error.localizedDescription)")
            }
            router.routeToPlayerStatsScreen(accountId: player.accountId)
        } else {
            let historyRecord = searchHistory[index]
            router.routeToPlayerStatsScreen(accountId: historyRecord.accountId)
        }
        
    }
    
    func loadSearchHistory() {
        do {
            searchHistory = try interactor.getSearchHistory().reversed()
            view.reloadTable()
        } catch {
            print("Failed to retreive history records \(error.localizedDescription)")
        }
    }
    
    func handleDeleteHistoryRecord(at index: Int) {
        do {
            let recordToDelete = searchHistory[index]
            try interactor.deleteSearchHistoryRecord(object: recordToDelete)
            searchHistory = try interactor.getSearchHistory().reversed()
            view.reloadTable()
        } catch {
            print("Failed to delete history record \(error.localizedDescription)")
        }
    }
    
}
