//
//  ArticleDetailsView.swift
//  ComeraTest
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import SwiftUI

struct ArticleDetailsView: View {
    @ObservedObject var viewModel: ArticleDetailsViewModel
    
    var body: some View {
        parentView
            .navigationTitle("Article")
    }
    
    private var parentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .zero) {
                imageView
                contentView
            }
        }
    }
    
    private var imageView: some View {
        AsyncImageView(
            url: viewModel.article.imageUrl,
            placeHolderHeight: 200
        )
        .frame(maxWidth: .infinity, idealHeight: 200)
        .scaledToFit()
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Spacer()
                .frame(height: 14)
            Text(viewModel.article.title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            Spacer()
                .frame(height: 20)
            Text(viewModel.article.abstract)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Spacer()
                .frame(height: 20)
            dateView
            Spacer()
                .frame(height: 20)
            
            TagsView(tags: viewModel.tags)
            
            linkView
        }
        .padding(.horizontal, 16)
    }
    
    private var dateView: some View {
        HStack(spacing: .zero) {
            Spacer()
            Image(systemName: "calendar")
                .resizable()
                .frame(width: 12, height: 10)
            Spacer()
                .frame(width: 6)
            Text(viewModel.article.publishedDateTimestamp)
                .font(.system(size: 12))
        }
        .font(.system(size: 12))
        .foregroundColor(.gray.opacity(0.7))
    }
    
    @ViewBuilder private var linkView: some View {
        if let url = viewModel.article.webUrl {
            Spacer()
                .frame(height: 50)
            HStack(spacing: .zero) {
                Spacer()
                Link(destination: url) {
                    Text("Full Article")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal, 30)
                        .background(
                            Color.gray
                                .cornerRadius(8)
                        )
                }
                Spacer()
            }
        }
    }
}

struct TagsView: View {
    let tags: [TagsCellModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(tags) {
                    tagView(model: $0)
                }
            }
        }
        .frame(height: 60)
    }
    
    private func tagView(model: TagsCellModel) -> some View {
        Text(model.tag)
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .medium))
            .padding(.vertical)
            .padding(.horizontal, 30)
            .background(Color.black.opacity(0.8))
            .clipShape(Capsule())
    }
}
