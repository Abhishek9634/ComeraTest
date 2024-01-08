//
//  ComeraTestUnitTests.swift
//  ComeraTestUnitTests
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import XCTest
import NetworkService
import Combine

final class ComeraTestUnitTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    private var apiClient: APIClient {
        return APIClientResolver.shared.apiClient
    }
    
    private var timeoutIntervalForRequest: TimeInterval {
        3.0
    }
    
    override func setUpWithError() throws {
        APIClientResolver.shared.mode = .mock
    }
    
    override func tearDownWithError() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testArticlesAPI() {
        let apiExpectation = expectation(description: "Articles API Completion Expectation")
        let router = NewsRouter.mostPopularArticles(days: 7)
        apiClient.request(request: router.urlRequest, type: ArticleResponse.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail(error.message)
                case .finished:
                    apiExpectation.fulfill()
                }
            } receiveValue: { response in
                XCTAssertNotNil(response)
            }
            .store(in: &cancellables)
        wait(for: [apiExpectation], timeout: timeoutIntervalForRequest)
    }
}

extension XCTestCase {
    func waitShortTime(
        _ seconds: TimeInterval = 2,
        reason: String = "Wait short time"
    ) {
        let exp = expectation(description: reason)
        let _ = XCTWaiter.wait(for: [exp], timeout: seconds)
    }
}
