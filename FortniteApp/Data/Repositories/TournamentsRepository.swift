//
//  TournamentsRepository.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 4/09/24.
//

import Foundation

/// Repository protocol responsible for fetching tournament data
protocol TournamentsRepositoryProtocol {
    /// Fetches a list of tournaments events for a given region
    /// - Parameter region: The region for which the tournaments will be fetched.
    /// - Returns: An array of `Event` model representing the tournaments
    /// - Throws: An error if the network request fails or the data cannot be decoded
    func getTournaments(region: Region) async throws -> [Event]
}

/// A concrete implementation of the `TournamentsRepositoryProtocol`.
/// This class handles fetching tournament data from the Fortnite API.
final class TournamentsRepository: TournamentsRepositoryProtocol {
    
    /// Networking manager used to perform API requests
    private let networkingManager: NetworkingManagerProtocol
    
    init(networkingManager: NetworkingManagerProtocol = NetworkingManager()) {
        self.networkingManager = networkingManager
    }
    
    /// Fetches a list of tournaments events for a given region
    /// - Parameter region: The region for which the tournaments will be fetched.
    /// - Returns: An array of `Event` model representing the tournaments.
    /// - Throws: An error if the network request fails or the data cannot be decoded.
    func getTournaments(region: Region) async throws -> [Event] {
        let queryParams = [
            URLQueryItem(name: "season", value: "current"),
            URLQueryItem(name: "region", value: region.rawValue)
        ]
        
        let request = Request(endpoint: "events/list", httpMethod: .GET, queryParams: queryParams)
        
        do {
            let response: EventsResponse = try await networkingManager.request(from: request)
            return response.events
        } catch {
            throw error
        }
    }
}
