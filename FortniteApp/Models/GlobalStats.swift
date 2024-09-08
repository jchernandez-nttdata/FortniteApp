//
//  GlobalStats.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/24.
//

import Foundation

struct GlobalStats: Decodable {
    let trio: ModeStats
    let squad: ModeStats
    let duo: ModeStats
    let solo: ModeStats
}

struct ModeStats: Decodable {
    let placetop1: Int
    let kd: Double
    let matchesplayed: Int
    let minutesplayed: Int
}
