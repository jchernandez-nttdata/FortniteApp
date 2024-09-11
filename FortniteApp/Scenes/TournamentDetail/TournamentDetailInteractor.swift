//
//  TournamentDetailInteractor.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 5/09/24.
//

import UIKit
import EventKit

protocol TournamentDetailInteractorProtocol {
    func getWindowDetail(windowId: String, page: Int) async throws -> WindowDetailResponse
    
    func addEventReminder(event: Event, window: EventWindow, completionHandler: @escaping (Result<Void,CalendarError>) -> Void)
}

final class TournamentDetailInteractor {
    private let tournamentsRepository: TournamentsRepositoryProtocol
    
    init(tournamentsRepository: TournamentsRepositoryProtocol = TournamentsRepository()) {
        self.tournamentsRepository = tournamentsRepository
    }
}

extension TournamentDetailInteractor: TournamentDetailInteractorProtocol {
    func getWindowDetail(windowId: String, page: Int) async throws -> WindowDetailResponse {
        return try await tournamentsRepository.getWindowDetail(windowId: windowId, page: page)
    }
    
    func addEventReminder(event: Event, window: EventWindow, completionHandler: @escaping (Result<Void,CalendarError>) -> Void) {
        let eventStore = EKEventStore()
        
        let calendarEvent = EKEvent(eventStore: eventStore)
        calendarEvent.title = event.title
        calendarEvent.startDate = window.beginTime
        calendarEvent.endDate = window.endTime
        calendarEvent.notes = "Get ready for the \(event.title) tournament. Don't miss it!"
        calendarEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        requestEventAccess(eventStore: eventStore) { granted, error in
            if granted && error == nil {
                do {
                    try eventStore.save(calendarEvent, span: .thisEvent, commit: true)
                    completionHandler(.success(()))
                } catch {
                    completionHandler(.failure(CalendarError.permissionDennied))
                }
            } else {
                completionHandler(.failure(CalendarError.permissionDennied))
            }
        }
    }
    
    private func requestEventAccess(eventStore: EKEventStore, completion: @escaping (Bool, Error?) -> Void) {
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToEvents(completion: completion)
        } else {
            eventStore.requestAccess(to: .event, completion: completion)
        }
    }
}
