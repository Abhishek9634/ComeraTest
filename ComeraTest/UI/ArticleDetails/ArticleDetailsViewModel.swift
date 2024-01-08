//
//  ArticleDetailsViewModel.swift
//  ComeraTest
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Combine

final class ArticleDetailsViewModel: ObservableObject {
    let article: Article
    @Published private(set) var tags: [TagsCellModel]
    
    init(article: Article) {
        self.article = article
        tags = article.keywords.components(separatedBy: ";").map {
            .init(tag: $0)
        }
    }
}

struct TagsCellModel: Identifiable {
    let tag: String
    
    var id: String {
        tag
    }
}
