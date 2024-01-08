//
//  HomeViewModel.swift
//  ComeraTest
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Combine
import Foundation
import NetworkService

final class HomeViewModel: ObservableObject {
    @Published private(set) var articles: [Article] = []
    @Published var currentFilter = Days.lastWeek
    
    private var apiClient: APIClient {
        APIClientResolver.shared.apiClient
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
    }
    
    func fetchArticles() {
        apiClient.getPopularNews(days: currentFilter.value)
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                print(response)
            }
            .store(in: &cancellables)
    }
}

extension HomeViewModel {
    enum Days: Int, CaseIterable {
        case yesterday = 1
        case lastWeek = 7
        case lastMonth = 30
        
        var value: Int {
            rawValue
        }
    }
}

extension Article: Identifiable {
}
