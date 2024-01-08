//
//  HomeViewModel.swift
//  ComeraTest
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Combine
import Foundation
import NetworkService

typealias Article = NetworkService.Article

final class HomeViewModel: ObservableObject {
    @Published var articleDetailsViewModel: ArticleDetailsViewModel?
    @Published private(set) var articles: [Article] = []
    @Published var isLoading = false
    @Published var currentFilter = Days.lastWeek
    @Published var showBottomSheet = false
    
    private var apiClient: APIClient {
        APIClientResolver.shared.apiClient
    }
    
    private(set) var alertModel: AlertModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        alertModel = .init(
            title: "Days",
            message: nil,
            buttons: [
                AlertButton(
                    title: "Yesterday",
                    action: { [weak self] in
                        self?.currentFilter = .yesterday
                    }
                ),
                AlertButton(
                    title: "7 Days",
                    action: { [weak self] in
                        self?.currentFilter = .lastWeek
                    }
                ),
                AlertButton(
                    title: "30 Days",
                    action: { [weak self] in
                        self?.currentFilter = .lastMonth
                    }
                )
            ]
        )
        
        $currentFilter
            .sink { [weak self] days in
                guard let self else {
                    return
                }
                fetchArticles(days: days)
            }
            .store(in: &cancellables)
    }
    
    func openBottomSheet() {
        showBottomSheet.toggle()
    }
    
    private func fetchArticles(days: Days) {
        self.isLoading = true
        apiClient.getPopularNews(days: days.value)
            .sink { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
                self?.isLoading = false
            } receiveValue: { [weak self] response in
                self?.articles = response.articles
            }
            .store(in: &cancellables)
    }
    
    func onTapArticle(article: Article) {
        articleDetailsViewModel = ArticleDetailsViewModel(article: article)
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
