//
//  APIClient.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Combine
import Foundation

public typealias APIOutput = Decodable & Mockable

public protocol Mockable {
    static var json: String { get }
}

public protocol APIRequest {
    func request<Output>(
        request: URLRequest,
        type: Output.Type
    ) -> AnyPublisher<Output, APIError> where Output: APIOutput
}

public protocol APIClient: APIRequest, APINews {
}
