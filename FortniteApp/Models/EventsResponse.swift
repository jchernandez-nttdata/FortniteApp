//
//  EventsResponse.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

struct EventsResponse: Decodable {
    let events: [Event]
}

struct Event: Decodable {
    let id: String
    let beginTime: Date
    let endTime: Date
    let poster: String?
    let shortDescription: String
    let nameLine1: String
    let nameLine2: String
    let windows: [EventWindow]
    
    private enum CodingKeys: String, CodingKey {
        case id, beginTime, endTime, poster, windows
        case nameLine1 = "name_line1"
        case nameLine2 = "name_line2"
        case shortDescription = "short_description"
    }
}

extension Event {
    var title: String {
        return "\(nameLine1) \(nameLine2)"
    }
    
    var sortedWindows: [EventWindow] {
        return windows.sorted { $0.beginTime < $1.beginTime }
    }
    
    var currentOrNextWindowEvent: EventWindow? {
        let currentDate = Date()
        
        // validates if the event is already finish
        if currentDate > endTime { return nil }
        
        return sortedWindows.first { window in
            (window.beginTime <= currentDate && window.endTime > currentDate) ||
            window.beginTime > currentDate
        }
        
    }
    
    var timeUntilDelta: TimeInterval? {
        let currentDate = Date()
        guard let currentOrNextWindowEvent else {
            return nil
        }
        
        return currentDate.distance(to: currentOrNextWindowEvent.beginTime)
    }
    
    var formattedTimeUntil: String? {
        guard let timeUntilDelta else {
            return nil
        }
        
        return DateHelper.formattedTimeUntilString(timeUntilDelta)
    }
}
