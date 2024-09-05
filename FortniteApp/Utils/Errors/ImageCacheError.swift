//
//  ImageCacheError.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 4/09/24.
//

import Foundation

/// An enumeration representing possible errors that can occur during image caching operations.
enum ImageCacheError: Error {
    case invalidURL
    case serverError
}
