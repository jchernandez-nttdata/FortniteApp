//
//  EventWindowDetailResponse.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 9/09/24.
//

import Foundation

struct WindowDetailResponse: Decodable {
    let result: Bool
    let page: Int
    let totalPages: Int
    let session: WindowDetail
}
