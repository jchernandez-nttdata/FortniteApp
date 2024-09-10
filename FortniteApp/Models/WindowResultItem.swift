//
//  WindowResultItem.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 10/09/24.
//

import Foundation

struct WindowResultItem: Decodable {
    let pointsEarned: Int
    let rank: Int
    let teamAccountNames: [PlayerAccount]
    
    var teamNamesString: String {
        return teamAccountNames.map { account in
            return account.name
        }.joined(separator: " + ")
    }
}

struct PlayerAccount: Decodable {
    let name: String
}
