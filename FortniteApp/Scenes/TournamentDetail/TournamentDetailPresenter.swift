//
//  TournamentDetailPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 5/09/24.
//

import Foundation

protocol TournamentDetailPresenterProtocol {
    var event: Event { get }
    
    func handleViewDidLoad()
}

final class TournamentDetailPresenter {
    unowned var view: TournamentDetailView!
    var router: TournamentDetailRouterProtocol!
    var interactor: TournamentDetailInteractorProtocol!
    
    internal var event: Event
    private var windowDetail: WindowDetailResponse?
    
    init(event: Event) {
        self.event = event
    }
}

extension TournamentDetailPresenter: TournamentDetailPresenterProtocol {
    func handleViewDidLoad() {
        Task {
            do {
                windowDetail = try await interactor.getWindowDetail(windowId: event.currentOrNextWindowEvent?.windowId ?? event.windows.first!.windowId, page: 0)
                print(windowDetail!)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
