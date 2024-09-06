//
//  PlayerSearchResponse.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/24.
//

import Foundation

struct PlayerSearchResponse: Codable {
    let result: Bool
    let matches: [PlayerSearchMatch]?
}

struct PlayerSearchMatch: Codable {
    let accountId: String
    let matches: [PlayerSearchMatchDetail]
}
