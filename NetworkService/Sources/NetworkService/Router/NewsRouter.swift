//
//  NewsRouter.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Foundation

public enum NewsRouter: APIRouter {
    case mostPopularArticles(days: Int)
    
    public var path: String {
        switch self {
        case .mostPopularArticles(let days):
            return "/svc/mostpopular/v2/mostviewed/all-sections/\(days).json"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .mostPopularArticles:
            return .get
        }
    }
    
    public var headers: [String : String] {
        switch self {
        case .mostPopularArticles:
            return ["Content-Type": "application/json"]
        }
    }
    
    public var params: [String : Any] {
        switch self {
        case .mostPopularArticles:
            return ["api-key": APIConstants.apiKey]
        }
    }
    
    public var baseUrl: String {
        switch self {
        case .mostPopularArticles:
            return APIConstants.baseUrl
        }
    }
}
