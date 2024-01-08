//
//  APIRouter.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Foundation

public protocol APIRouter {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var baseUrl: String { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    
    var value: String { rawValue }
}

extension APIRouter {
    var timeout: TimeInterval { 60 }
    
    var urlRequest: URLRequest {
        let url: URL
        var httpBody: Data?
        
        switch method {
        case .get:
            var components = URLComponents(
                url: URL(string: baseUrl + path)!,
                resolvingAgainstBaseURL: false
            )!
            if !params.isEmpty {
                components.queryItems = params.map {
                    .init(name: $0.key, value: String(describing: $0.value))
                }
            }
            url = components.url!
        default:
            url = URL(string: baseUrl + path)!
            httpBody = try! JSONSerialization.data(withJSONObject: params)
        }
                
        var request = URLRequest(url: url)
        request.httpBody = httpBody
        request.httpMethod = method.value
        request.allHTTPHeaderFields = headers
        
        return request
    }
}
