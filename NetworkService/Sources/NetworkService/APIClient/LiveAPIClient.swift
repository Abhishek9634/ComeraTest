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
    private let enableLogs = true
    
    private init() {
    }
    
    public func request<Output>(
        request: URLRequest,
        type: Output.Type
    ) -> AnyPublisher<Output, APIError> where Output: APIOutput {
        logRequest(request: request)
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                APIError.custom(
                    code: error.errorCode,
                    message: error.localizedDescription
                )
            }
            .tryMap { [weak self] (data, response) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.failure(message: "NIL URL Response")
                }
                
                guard 200...299 ~= httpResponse.statusCode else {
                    throw APIError.failure(message: "Failed with code: \(httpResponse.statusCode)")
                }
                
                self?.logResponse(data: data, url: response.url)
                
                return data
            }
            .decode(type: type, decoder: JSONDecoder())
            .mapError { error in
                print(error)
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

extension LiveAPIClient {
    private func logRequest(request: URLRequest) {
        if enableLogs {
            print("REQUEST:", request.url ?? "NIL")
            print("METHOD::", request.httpMethod ?? "NIL")
            print("HEADERS:", request.allHTTPHeaderFields ?? "NIL")
            
            do {
                if let data = request.httpBody {
                    let json = try JSONSerialization.jsonObject(with: data)
                    print("PARAMS:", json)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func logResponse(data: Data, url: URL?) {
        if enableLogs {
            DispatchQueue(label: "Http Response", qos: .background)
                .async {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data)
                        print("RESPONSE:", url ?? "NIL")
                        print(json)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
