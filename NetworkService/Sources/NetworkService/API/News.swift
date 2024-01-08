//
//  News.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Combine

public protocol APINews {
    func getPopularNews(days: Int) -> AnyPublisher<ArticleResponse, APIError>
}

public extension LiveAPIClient {
    func getPopularNews(days: Int) -> AnyPublisher<ArticleResponse, APIError> {
        let router = NewsRouter.mostPopularArticles(days: days)
        return request(request: router.urlRequest, type: ArticleResponse.self)
    }
}
