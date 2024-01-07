//
//  APIError.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Foundation

public enum APIError: Error {
    case `default`
    case failure(message: String)
    case custom(code: Int, message: String)
    
    public var message: String {
        switch self {
        case .default:
            return "Oops!!! Something went wrong"
        case .failure(let message):
            return message
        case .custom(_, let message):
            return message
        }
    }
    
    public var code: Int {
        switch self {
        case .default, .failure:
            return 0
        case .custom(let code, _):
            return code
        }
    }
}
