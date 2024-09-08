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
    func handleDidSelectPlayer(at index: Int, isHistory: Bool)
    func handleViewDidLoad()
    func handleDeleteHistoryRecord(at index: Int)
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
        view.hideError()

        // show history if query is empty
        guard !query.isEmpty else {
            playerMatches = []
            view.reloadSearchTableView()
            toggleTablesVisibility(isHistoryHidden: false)
            return
        }
        
        view.showLoading()
        toggleTablesVisibility(isHistoryHidden: true)
        Task {
            do {
                playerMatches = try await interactor.searchPlayer(query: query)
                if playerMatches.isEmpty {
                    view.dismissLoading()
                    view.setSearchTableViewVisibility(isHidden: true)
                    view.showError(title: "No results", description: "Sorry, no results were found for your search. Please try searching for a different player.")
                    return
                }
                view.reloadSearchTableView()
                view.dismissLoading()
                toggleTablesVisibility(isHistoryHidden: true)
            } catch {
                view.setSearchTableViewVisibility(isHidden: true)
                view.showError(title: "Something went wrong", description: "An error occurred while searching players from the server. Please try again later.")
                view.dismissLoading()
            }
        }
    }
    
    func handleDidSelectPlayer(at index: Int, isHistory: Bool) {
        
        if !isHistory {
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
            // TODO: navigate
        } else {
            // TODO: navigate
        }
        
    }
    
    func handleViewDidLoad() {
        do {
            searchHistory = try interactor.getSearchHistory().reversed()
            view.reloadHistoryTableView()
        } catch {
            print("Failed to retreive history records \(error.localizedDescription)")
        }
    }
    
    func handleDeleteHistoryRecord(at index: Int) {
        do {
            let recordToDelete = searchHistory[index]
            try interactor.deleteSearchHistoryRecord(object: recordToDelete)
            searchHistory = try interactor.getSearchHistory().reversed()
            view.reloadHistoryTableView()
        } catch {
            print("Failed to delete history record \(error.localizedDescription)")
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
