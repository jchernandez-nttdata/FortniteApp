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
    func getEvent(at index: Int, section: TournamentsSection) -> Event
    func handleRegionChanged(region: Region)
    func handleDidSelectEvent(at index: Int, section: TournamentsSection)
}

final class TournamentsPresenter {
    
    unowned var view: TournamentsView!
    var interactor: TournamentsInteractorProtocol!
    var router: TournamentsRouterProtocol!
    
    private var upcomingEvents: [Event] = []
    private var endedEvents: [Event] = []
    private var currentRegion: Region = .NAC
    
}

extension TournamentsPresenter: TournamentsPresenterProtocol {
    var tournamentSections: [TournamentsSection] {
        TournamentsSection.allCases
    }
    
    var eventsCount: (upcoming: Int, ended: Int) {
        (upcomingEvents.count, endedEvents.count)
    }
    
    func getEvent(at index: Int, section: TournamentsSection) -> Event {
        switch section {
            
        case .upcomingEvents:
            return upcomingEvents[index]
        case .endedEvents:
            return endedEvents[index]
        }
    }
    
    func handleViewDidLoad() {
        loadTournaments(for: .NAC)
    }
    
    func handleRegionChanged(region: Region) {
        if currentRegion == region {
            return
        }
        currentRegion = region
        loadTournaments(for: region)
    }
    
    func handleDidSelectEvent(at index: Int, section: TournamentsSection) {
        let event: Event = switch section {
        case .upcomingEvents:
            upcomingEvents[index]
        case .endedEvents:
            endedEvents[index]
        }
        
        router.routeToDetailScreen(event: event)
    }
    
    // MARK: - Private methods
    
    private func loadTournaments(for region: Region) {
        view.showLoading()
        Task {
            do {
                let events = try await interactor.getTournaments(region: region)
                if events.isEmpty {
                    //TODO: Handle empty case
                    return
                }
                let (upcomingEvents, endedEvents) = handleEvents(events: events)
                self.upcomingEvents = upcomingEvents
                self.endedEvents = endedEvents
                view.reloadCollectionView()
                view.dismissLoading()
            } catch {
                // TODO: Handle error case
                view.dismissLoading()
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
