//
//  TournamentsPresenter.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol TournamentsPresenterProtocol {
    var tournamentSections: [TournamentsSection] { get }
    var eventsCount: (upcoming: Int, ended: Int) { get }
    
    func handleViewDidLoad()
    func getEventAt(_ index: Int, section: TournamentsSection) -> Event
}

final class TournamentsPresenter {
    
    unowned var view: TournamentsView!
    var interactor: TournamentsInteractorProtocol!
    var router: TournamentsRouterProtocol!
    
    private var upcomingEvents: [Event] = []
    private var endedEvents: [Event] = []
    
}

extension TournamentsPresenter: TournamentsPresenterProtocol {
    func getEventAt(_ index: Int, section: TournamentsSection) -> Event {
        switch section {
            
        case .upcomingEvents:
            return upcomingEvents[index]
        case .endedEvents:
            return endedEvents[index]
        }
    }
    
    var tournamentSections: [TournamentsSection] {
        TournamentsSection.allCases
    }
    
    var eventsCount: (upcoming: Int, ended: Int) {
        (upcomingEvents.count, endedEvents.count)
    }
    
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
                view.reloadCollectionView()
                
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
        
        return (upcomingEvents.sorted { $0.timeUntilDelta! < $1.timeUntilDelta! }, endedEvents)
        
    }
    
    
}
