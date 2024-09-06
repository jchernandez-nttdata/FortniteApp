//
//  TournamentDetailPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 5/09/24.
//

import Foundation

protocol TournamentDetailPresenterProtocol {
    var event: Event { get }
}

final class TournamentDetailPresenter {
    unowned var view: TournamentDetailView!
    var router: TournamentDetailRouterProtocol!
    var interactor: TournamentDetailInteractorProtocol!
    
    internal var event: Event
    
    init(event: Event) {
        self.event = event
    }
}

extension TournamentDetailPresenter: TournamentDetailPresenterProtocol {
    
}
