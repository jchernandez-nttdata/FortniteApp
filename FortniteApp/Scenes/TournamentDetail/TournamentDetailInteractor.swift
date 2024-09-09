//
//  TournamentDetailInteractor.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 5/09/24.
//

import UIKit

protocol TournamentDetailInteractorProtocol {
    func getWindowDetail(windowId: String, page: Int) async throws -> WindowDetailResponse
}

final class TournamentDetailInteractor {
    private let tournamentsRepository: TournamentsRepositoryProtocol
    
    init(tournamentsRepository: TournamentsRepositoryProtocol = TournamentsRepository()) {
        self.tournamentsRepository = tournamentsRepository
    }
}

extension TournamentDetailInteractor: TournamentDetailInteractorProtocol {
    func getWindowDetail(windowId: String, page: Int) async throws -> WindowDetailResponse {
        return try await tournamentsRepository.getWindowDetail(windowId: windowId, page: page)
    }
}
