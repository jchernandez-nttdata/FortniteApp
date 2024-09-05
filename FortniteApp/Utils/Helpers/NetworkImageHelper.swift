//
//  NetworkImageHelper.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 4/09/24.
//

import UIKit

/// A helper class responsible for fetching and caching images from the network.
class NetworkImageHelper {
    
    static let shared = NetworkImageHelper()
    
    /// Cache storage where the data is saved
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() { }
    
    /// Gets an image from the cache if available, or downloads it from the network if not.
    /// - Parameters:
    ///   - url: The string URL of the image to fetch.
    ///   - completion: A completion handler returning either the cached/downloaded `UIImage` or an `ImageCacheError`.
    func getCacheImage(from url: String, completion: @escaping (Result<UIImage?, ImageCacheError>) -> Void ) {
        
        guard let url = URL(string: url) else {
            return completion(.failure(ImageCacheError.invalidURL))
        }
        
        // We use the url as key
        let key = url.absoluteString as NSString
        
        // The image was found in cache
        if let data = imageDataCache.object(forKey: key) {
            return completion(.success(UIImage(data: data as Data)))
        }
        
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(ImageCacheError.serverError))
                return
            }
            
            // save image in cache
            let value = data as NSData
            self.imageDataCache.setObject(value, forKey: key)
            
            completion(.success(UIImage(data: data as Data)))
            
        }.resume()
    }
    
    
}
