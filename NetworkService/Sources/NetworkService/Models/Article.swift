//
//  Article.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Foundation

public struct Article: Decodable {
    public let id: Int
    public let title: String
    public let source: String
    public let byLine: String
    public let publishedDateTimestamp: String
    public let url: String
    public let section: String
    public let keywords: String
    public let abstract: String
    public let media: [Media]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case source
        case byLine = "byline"
        case publishedDateTimestamp = "published_date"
        case url
        case section
        case keywords = "adx_keywords"
        case abstract
        case media
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.source = try container.decode(String.self, forKey: .source)
        self.byLine = try container.decode(String.self, forKey: .byLine)
        self.publishedDateTimestamp = try container.decode(String.self, forKey: .publishedDateTimestamp)
        self.url = try container.decode(String.self, forKey: .url)
        self.section = try container.decode(String.self, forKey: .section)
        self.keywords = try container.decode(String.self, forKey: .keywords)
        self.abstract = try container.decode(String.self, forKey: .abstract)
        self.media = try container.decode([Media].self, forKey: .media)
    }
}

public extension Article {
    var metaData: [MediaMetaData] {
        media.first?.metaData ?? []
    }
}

public struct Media: Decodable {
    public let metaData: [MediaMetaData]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "media-metadata"
    }
}


public struct MediaMetaData: Decodable {
    public let url: String
    public let width: Int
    public let height: Int
}
