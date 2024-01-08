//
//  MockNews.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Combine
import Foundation

public extension MockAPIClient {
    func getPopularNews(days: Int) -> AnyPublisher<ArticleResponse, APIError> {
        request(type: ArticleResponse.self)
    }
}
