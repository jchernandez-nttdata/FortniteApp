//
//  Scoring.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 9/09/24.
//

import Foundation

struct WindowScoring: Decodable {
    let trackedStat: ScoreType
    let rewardTiers: [ScoreDetail]
}

struct ScoreDetail: Decodable {
    let keyValue: Int
    let pointsEarned: Int
}
