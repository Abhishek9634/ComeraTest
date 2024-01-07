//
//  APIClient.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Combine

public protocol Mockable {
    static var json: String { get }
}

public protocol APIClient {
    func request<Output>(type: Output.Type) -> AnyPublisher<Output, APIError> where Output: Decodable & Mockable
}

public final class APIClientResolver {
    public static let shared = APIClientResolver()
    public var mode: APIMode = .live

    private init() {
    }

    public var apiClient: APIClient {
        switch mode {
        case .live:
            return LiveAPIClient.shared
        case .mock:
            return MockAPIClient.shared
        }
    }
}

extension APIClientResolver {
    public enum APIMode {
        case live
        case mock
    }
}
