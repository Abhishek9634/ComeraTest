//
//  MockAPIClient.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Foundation
import Combine

public final class MockAPIClient: APIClient {
    
    public static let shared = MockAPIClient()
    
    private init() {
    }
    
    public func request<Output>(type: Output.Type) -> AnyPublisher<Output, APIError> where Output : Decodable & Mockable {
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
