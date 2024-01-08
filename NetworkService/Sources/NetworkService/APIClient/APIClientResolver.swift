//
//  APIClientResolver.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Foundation

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
