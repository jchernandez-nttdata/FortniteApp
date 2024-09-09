//
//  NetworkingError.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

/// An enumeration representing possible errors that can occur during network operations.
enum NetworkingError: Error {
    case invalidURL
    case requestFailed(statusCode: Int?)
    case decodeFailure
    case invalidResponse
    case serverError(description: String)
}
