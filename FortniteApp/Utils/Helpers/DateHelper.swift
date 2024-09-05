//
//  DateHelper.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 5/09/24.
//

import Foundation

/// A helper class responsible for formatting dates or related
struct DateHelper {
    /// This function formats a TimeInterval indicating how much time is left until a certain event.
    /// - Parameter timeInterval: The time interval in seconds representing the time remaining until the event. If negative, the event is considered to be live.
    /// - Returns:  A string describing the time remaining.
    static func formattedTimeUntilString(_ timeInterval: TimeInterval) -> String {
        if timeInterval < 0 {
            return "LIVE"
        } else if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            return "in \(minutes) minute" + (minutes == 1 ? "" : "s")
        } else if timeInterval < 86400 {
            let hours = Int(timeInterval / 3600)
            return "in \(hours) hour" + (hours == 1 ? "" : "s")
        } else {
            let days = Int(timeInterval / 86400)
            return "in \(days) day" + (days == 1 ? "" : "s")
        }
    }
}
