//
//  Request.swift
//  FortniteApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/24.
//

import Foundation

/// Represents an HTTP request with an endpoint, HTTP method, and optional query parameters.
struct Request {
    /// The endpoint of the request
    let endpoint: String
    
    /// The HTTP method of the request
    let httpMethod: HttpMethod
    
    /// An array of query parameters, if any
    let queryParams: [URLQueryItem]
    
    /// Creates a new `Request` instance
    /// - Parameters:
    ///   - endpoint: Endpoint string of the request
    ///   - httpMethod: HTTP method of the request
    ///   - queryParams: An array of query parameters, if any
    init(
        endpoint: String,
        httpMethod: HttpMethod,
        queryParams: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.httpMethod = httpMethod
        self.queryParams = queryParams
    }
    
    /// Converts the `Request` instance into a `URLRequest` for use with network requests.
    /// - Returns: An optional `URLRequest` instance if the URL is valid.
    func toUrlRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: APIConstants.baseURL + endpoint) else {
            return nil
        }
        
        if (!queryParams.isEmpty) {
            urlComponents.queryItems = queryParams
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue(APIConstants.apiKey, forHTTPHeaderField: "Authorization")
        
        return request
    }
}

