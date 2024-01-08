//
//  MockAPIClient.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Combine
import Foundation

public final class MockAPIClient: APIClient {
    public static let shared = MockAPIClient()
    
    private init() {
    }
    
    public func request<Output>(
        request: URLRequest = .empty,
        type: Output.Type
    ) -> AnyPublisher<Output, APIError> where Output: APIOutput {
        guard let data = type.json.data(using: .utf8) else {
            return Fail(error: APIError.failure(message: "Failed to covert mock data"))
                .eraseToAnyPublisher()
        }
        return Just(data)
            .decode(type: type, decoder: JSONDecoder())
            .mapError { APIError.failure(message: $0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}

public extension URLRequest {
    static var empty: URLRequest {
        URLRequest(url: URL(string: "")!)
    }
}
