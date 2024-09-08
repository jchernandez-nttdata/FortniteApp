//
//  PlayerSearchResponse.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/24.
//

import Foundation

struct PlayerSearchResponse: Decodable {
    let result: Bool
    let matches: [PlayerSearchMatch]?
}

struct PlayerSearchMatch: Decodable {
    let accountId: String
    let matches: [PlayerSearchMatchDetail]
}
