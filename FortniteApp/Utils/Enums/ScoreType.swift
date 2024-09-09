//
//  scoreType.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 9/09/24.
//

import Foundation

enum ScoreType: String, Decodable {
    case placement = "PLACEMENT_STAT_INDEX"
    case eliminations = "TEAM_ELIMS_STAT_INDEX"
}
