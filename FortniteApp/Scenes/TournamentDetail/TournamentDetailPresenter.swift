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
    
    func handleViewDidLoad()
}

final class TournamentDetailPresenter {
    unowned var view: TournamentDetailView!
    var router: TournamentDetailRouterProtocol!
    var interactor: TournamentDetailInteractorProtocol!
    
    var event: Event
    var windowDetail: WindowDetailResponse?
    
    init(event: Event) {
        self.event = event
    }
}

extension TournamentDetailPresenter: TournamentDetailPresenterProtocol {
    func handleViewDidLoad() {
        Task {
            do {
                windowDetail = try await interactor.getWindowDetail(windowId: event.currentOrNextWindowEvent?.windowId ?? event.windows.first!.windowId, page: 0) //TODO: handle page
                view.setupEventDetails()
                view.reloadWindowData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
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
}
