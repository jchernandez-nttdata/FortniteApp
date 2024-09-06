//
//  StatsRepository.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/24.
//

import Foundation


/// Repository protocol resposible for fetching player and player stats data
protocol StatsRepositoryProtocol {
    
    /// Searches for players that match the provided username query.
    /// - Parameter query: A string representing the username or partial username to search for.
    /// - Returns: An array of `PlayerSearchMatch` objects representing the matched players.
    /// - Throws: An error if the network request fails or the data cannot be decoded
    func searchPlayer(query: String) async throws -> [PlayerSearchMatch]
}

/// A concrete implementation of the `StatsRepositoryProtocol`.
/// This class handles fetching player data from the Fortnite API.
final class StatsRepository: StatsRepositoryProtocol {
    
    /// Networking manager used to perform API requests
    private let networkingManager: NetworkingManagerProtocol
    
    init(networkingManager: NetworkingManagerProtocol = NetworkingManager()) {
        self.networkingManager = networkingManager
    }
    
    /// Searches for players that match the provided username query.
    /// - Parameter query: A string representing the username or partial username to search for.
    /// - Returns: An array of `PlayerSearchMatch` objects representing the matched players.
    /// - Throws: An error if the network request fails or the data cannot be decoded
    func searchPlayer(query: String) async throws -> [PlayerSearchMatch] {
        let queryParams = [
            URLQueryItem(name: "username", value: query),
        ]
        
        let request = Request(endpoint: "lookup/advanced", httpMethod: .GET, queryParams: queryParams, apiVersion: 2)
        
        do {
            let response: PlayerSearchResponse = try await networkingManager.request(from: request)
            guard let matches = response.matches, response.result else {
                return []
            }
            return matches
        } catch {
            if let networkingError = error as? NetworkingError {
                switch networkingError {
                case .requestFailed(let statusCode) where statusCode == 404:
                    return []
                default:
                    throw networkingError
                }
            }
            
            throw error
        }
    }
    
    
}
