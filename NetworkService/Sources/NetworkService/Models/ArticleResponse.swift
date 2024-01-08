//
//  ArticleResponse.swift
//  
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import Foundation

public struct ArticleResponse {
    public let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case articles = "results"
    }
}

extension ArticleResponse: APIOutput {
    static public var json: String {
        """
        {
          "status": "OK",
          "copyright": "Copyright (c) 2024 The New York Times Company.  All Rights Reserved.",
          "num_results": 20,
          "results": [
            {
              "uri": "nyt://article/633ffdef-7d38-50fa-9b79-bdb3fe0e6975",
              "url": "https://www.nytimes.com/2024/01/05/nyregion/wayne-lapierre-resigns-nra.html",
              "id": 100000009252695,
              "asset_id": 100000009252695,
              "source": "New York Times",
              "published_date": "2024-01-05",
              "updated": "2024-01-05 23:08:16",
              "section": "New York",
              "subsection": "",
              "nytdsection": "new york",
              "adx_keywords": "Appointments and Executive Changes;Attorneys General;Corruption (Institutional);Suits and Litigation (Civil);LaPierre, Wayne;James, Letitia;National Rifle Assn;New York State",
              "column": null,
              "byline": "By Danny Hakim",
              "type": "Article",
              "title": "Wayne LaPierre Resigns From N.R.A. With Trial Set to Open",
              "abstract": "The resignation of Mr. LaPierre, the National Rifle Association’s longtime leader, came as he faced a corruption trial in Manhattan.",
              "des_facet": [
                "Appointments and Executive Changes",
                "Attorneys General",
                "Corruption (Institutional)",
                "Suits and Litigation (Civil)"
              ],
              "org_facet": [
                "National Rifle Assn"
              ],
              "per_facet": [
                "LaPierre, Wayne",
                "James, Letitia"
              ],
              "geo_facet": [
                "New York State"
              ],
              "media": [
                {
                  "type": "image",
                  "subtype": "photo",
                  "caption": "Wayne LaPierre had led the N.R.A. for more than three decades.",
                  "copyright": "Michael Conroy/Associated Press",
                  "approved_for_syndication": 1,
                  "media-metadata": [
                    {
                      "url": "https://static01.nyt.com/images/2024/01/05/multimedia/05nra1-gpjt/05nra1-gpjt-thumbStandard.jpg",
                      "format": "Standard Thumbnail",
                      "height": 75,
                      "width": 75
                    },
                    {
                      "url": "https://static01.nyt.com/images/2024/01/05/multimedia/05nra1-gpjt/05nra1-gpjt-mediumThreeByTwo210.jpg",
                      "format": "mediumThreeByTwo210",
                      "height": 140,
                      "width": 210
                    },
                    {
                      "url": "https://static01.nyt.com/images/2024/01/05/multimedia/05nra1-gpjt/05nra1-gpjt-mediumThreeByTwo440.jpg",
                      "format": "mediumThreeByTwo440",
                      "height": 293,
                      "width": 440
                    }
                  ]
                }
              ],
              "eta_id": 0
            },
            {
              "uri": "nyt://article/0666f60d-3589-556d-9756-90e33df6600f",
              "url": "https://www.nytimes.com/2024/01/03/arts/tetris-beat-blue-scuti.html",
              "id": 100000009247570,
              "asset_id": 100000009247570,
              "source": "New York Times",
              "published_date": "2024-01-03",
              "updated": "2024-01-05 20:47:34",
              "section": "Arts",
              "subsection": "",
              "nytdsection": "arts",
              "adx_keywords": "Computer and Video Games;Records and Achievements;Nintendo Co Ltd;Oklahoma",
              "column": null,
              "byline": "By Sopan Deb",
              "type": "Article",
              "title": "Boy, 13, Is Believed to Be the First to ‘Beat’ Tetris",
              "abstract": "Willis Gibson, a competitive Tetris player prodigy from Oklahoma, advanced so far in the original Nintendo version of the game that it froze. “I can’t feel my fingers,” he said afterward.",
              "des_facet": [
                "Computer and Video Games",
                "Records and Achievements"
              ],
              "org_facet": [
                "Nintendo Co Ltd"
              ],
              "per_facet": [],
              "geo_facet": [
                "Oklahoma"
              ],
              "media": [
                {
                  "type": "image",
                  "subtype": "photo",
                  "caption": "",
                  "copyright": "Willis Gibson",
                  "approved_for_syndication": 1,
                  "media-metadata": [
                    {
                      "url": "https://static01.nyt.com/images/2024/01/03/multimedia/03xp-tetris-SS/03xp-tetris-SS-thumbStandard-v2.jpg",
                      "format": "Standard Thumbnail",
                      "height": 75,
                      "width": 75
                    },
                    {
                      "url": "https://static01.nyt.com/images/2024/01/03/multimedia/03xp-tetris-SS/03xp-tetris-SS-mediumThreeByTwo210-v2.jpg",
                      "format": "mediumThreeByTwo210",
                      "height": 140,
                      "width": 210
                    },
                    {
                      "url": "https://static01.nyt.com/images/2024/01/03/multimedia/03xp-tetris-SS/03xp-tetris-SS-mediumThreeByTwo440-v2.jpg",
                      "format": "mediumThreeByTwo440",
                      "height": 293,
                      "width": 440
                    }
                  ]
                }
              ],
              "eta_id": 0
            }
          ]
        }
        """
    }
}
