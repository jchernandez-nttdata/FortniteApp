//
//  TournamentsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol TournamentsPresenterProtocol {
    func handleViewDidLoad()
}

final class TournamentsPresenter {
    
    weak var view: TournamentsView!
    var interactor: TournamentsInteractorProtocol!
    var router: TournamentsRouterProtocol!
    
    private var upcomingEvents: [Event] = []
    private var endedEvents: [Event] = []
    
}

extension TournamentsPresenter: TournamentsPresenterProtocol {
    func handleViewDidLoad() {
        // TODO: Handle loading
        Task {
            do {
                let events = try await interactor.getTournaments(region: .NAC)
                if events.isEmpty {
                    //TODO: Handle empty case
                }
                let (upcomingEvents, endedEvents) = handleEvents(events: events)
                self.upcomingEvents = upcomingEvents
                self.endedEvents = endedEvents
                print(upcomingEvents)
                
            } catch {
                print(error)
                // TODO: Handle error case
            }
        }
    }
    
    private func handleEvents(events: [Event]) -> (upcomingEvents: [Event], endedEvents: [Event]) {
        
        let upcomingEvents = events.filter { event in
            event.currentOrNextWindowEvent != nil
        }
        
        let endedEvents = events.filter { event in
            event.currentOrNextWindowEvent == nil
        }
        
        return (upcomingEvents, endedEvents)
        
    }
    
    
}
