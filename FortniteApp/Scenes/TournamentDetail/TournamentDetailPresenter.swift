//
//  TournamentDetailPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 5/09/24.
//

import Foundation

protocol TournamentDetailPresenterProtocol {
    var event: Event { get }
    var windowScoring: WindowScoring? { get }
    var windowEliminationValue: Int? { get }
    var windowResults: [WindowResultItem] { get }
    var selectedWindow: EventWindow? { get }
    
    func handleViewDidLoad()
    func handleWindowSelect(at index: Int)
    func handleBackButtonTap()
}

final class TournamentDetailPresenter {
    unowned var view: TournamentDetailView!
    var router: TournamentDetailRouterProtocol!
    var interactor: TournamentDetailInteractorProtocol!
    
    var event: Event
    var windowDetail: WindowDetailResponse?
    var selectedWindow: EventWindow?
    
    init(event: Event) {
        self.event = event
    }
}

extension TournamentDetailPresenter: TournamentDetailPresenterProtocol {
    var windowScoring: WindowScoring? {
        return windowDetail?.session.rules.scoring.first { windowScoring in
            windowScoring.trackedStat == .placement
        }
    }
    
    var windowEliminationValue: Int? {
        let eliminations = windowDetail?.session.rules.scoring.first { windowScoring in
            windowScoring.trackedStat == .eliminations
        }
        return eliminations?.rewardTiers.first?.pointsEarned
    }
    
    var windowResults: [WindowResultItem] {
        return windowDetail?.session.results ?? []
    }
    
    func handleViewDidLoad() {
        selectedWindow = event.currentOrNextWindowEvent ?? event.sortedWindows.first!
        loadWindowDetail(windowId: selectedWindow!.windowId)
    }
    
    func handleWindowSelect(at index: Int) {
        let window = event.sortedWindows[index]
        if window.windowId != selectedWindow!.windowId {
            selectedWindow = window
            loadWindowDetail(windowId: window.windowId)
        }
    }
    
    func handleBackButtonTap() {
        router.routePop()
    }
    
    private func loadWindowDetail(windowId: String) {
        view.showLoading()
        Task {
            do {
                windowDetail = try await interactor.getWindowDetail(windowId: windowId, page: 0)
                view.setupEventDetails()
                view.reloadWindowData()
                view.dismissLoading()
            } catch {
                view.dismissLoading()
                print(error.localizedDescription)
            }
        }
    }
}
