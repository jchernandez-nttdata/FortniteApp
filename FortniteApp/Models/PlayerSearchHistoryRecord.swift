//
//  SearchHistoryItem.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 7/09/24.
//

import Foundation
import RealmSwift

class PlayerSearchHistoryRecord: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var platform: String
    @Persisted var accountId: String

    convenience init(name: String, platform: String, accountId: String) {
        self.init()
        self.name = name
        self.platform = platform
        self.accountId = accountId
    }
}
