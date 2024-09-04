//
//  NetworkingManager.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

/// A protocol defining the methods for making network requests.
protocol NetworkingManagerProtocol {

    /// Makes a network request and decodes the response data into the specified type asynchronously.
    /// - Parameter request: The `Request` object containing the endpoint, HTTP method, and query parameters.
    /// - Returns: The decoded data of type `T`.
    /// - Throws: An error if the network request fails or if decoding the data fails.
    func request<T: Decodable>(from request: Request) async throws -> T
}

/// A class that manages network requests and handles decoding of response data.
final class NetworkingManager: NetworkingManagerProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request<T: Decodable>(from request: Request) async throws -> T {
        guard let request = request.toUrlRequest() else {
            throw NetworkingError.invalidURL
        }
        
        let (data, response) = try await urlSession.data(for: request)
        
        if let responseError = self.isValidResponse(response: response) {
            throw responseError
        }
        
        return try self.decodeFrom(data)
        
    }
    
    // MARK: private methods
    
    private func decodeFrom<T: Decodable>(_ data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    private func isValidResponse(response: URLResponse?) -> Error? {
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return NetworkingError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            return NetworkingError.requestFailed(statusCode: httpResponse.statusCode)
        }
        
        return nil
    }
}
