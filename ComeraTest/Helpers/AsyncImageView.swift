//
//  AsyncImageView.swift
//  AvomaTest
//
//  Created by Abhishek Thapliyal on 03/12/23.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let contentMode: ContentMode
    let placeHolderHeight: CGFloat
    
    init(url: URL?, placeHolderHeight: CGFloat, contentMode: ContentMode = .fit) {
        self.url = url
        self.placeHolderHeight = placeHolderHeight
        self.contentMode = contentMode
    }
    
    var body: some View {
        if let url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    Color.gray
                        .frame(maxWidth: .infinity, minHeight: placeHolderHeight)
                        .overlay(ProgressView())
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: contentMode)
                default:
                    EmptyView()
                }
            }
        } else {
            Color.gray
                .frame(maxWidth: .infinity, minHeight: placeHolderHeight)
        }
    }
}
