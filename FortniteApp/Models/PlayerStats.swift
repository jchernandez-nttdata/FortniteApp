//
//  PlayerStats.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import Foundation

struct PlayerStats: Decodable {
    let name: String
    let account: AccountInfo
    let global_stats: GlobalStats
}
