//
//  TournamentsInteractor.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

protocol TournamentsInteractorProtocol {
    func getTournaments(region: Region) async throws -> [Event]
}

final class TournamentsInteractor {
    
    private let tournamentsRepository: TournamentsRepositoryProtocol
    
    init(tournamentsRepository: TournamentsRepositoryProtocol = TournamentsRepository()) {
        self.tournamentsRepository = tournamentsRepository
    }
    
}

extension TournamentsInteractor: TournamentsInteractorProtocol {
    func getTournaments(region: Region) async throws -> [Event] {
        return try await tournamentsRepository.getTournaments(region: region)
    }
}
