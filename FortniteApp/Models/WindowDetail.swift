//
//  WindowDetail.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 9/09/24.
//

import Foundation
struct WindowDetail: Decodable {
    let eventId: String
    let windowId: String
    let beginTime: Date
    let endTime: Date
    let rules: WindowRules
    let results: [WindowResultItem]
}
