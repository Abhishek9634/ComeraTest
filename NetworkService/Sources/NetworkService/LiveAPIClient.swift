//
//  LiveAPIClient.swift
//
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Foundation
import Combine

public final class LiveAPIClient: APIClient {
    
    public static let shared = LiveAPIClient()
    
    private init() {
    }
    
    public func request<Output>(type: Output.Type) -> AnyPublisher<Output, APIError> where Output : Decodable & Mockable {
        guard let url = URL(string: APIConstants.githubUrl) else {
            return Fail(error: APIError.default).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error in
                APIError.custom(
                    code: error.errorCode,
                    message: error.localizedDescription
                )
            }
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw APIError.default
                }
                return data
            }
            .decode(type: type, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case let apiError as APIError:
                    return apiError
                default:
                    return APIError.failure(
                        message: error.localizedDescription
                    )
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
