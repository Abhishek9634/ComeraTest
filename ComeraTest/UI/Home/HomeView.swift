//
//  HomeView.swift
//  ComeraTest
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            parentView
                .navigationTitle("Articles")
                .loader(isLoading: $viewModel.isLoading)
                .segue(viewModel: $viewModel.articleDetailsViewModel) {
                    ArticleDetailsView(viewModel: $0)
                }
                .viewDidLoad {
                    viewModel.fetchArticles()
                }
        }
    }
    
    private var parentView: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.articles) { model in
                    VStack(spacing: 10) {
                        articleCell(model: model)
                        Color.black.opacity(0.15)
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .onTapGesture {
                        viewModel.onTapArticle(article: model)
                    }
                }
            }
        }
    }
    
    private func articleCell(model: Article) -> some View {
        HStack(spacing: .zero) {
            AsyncImageView(url: model.iconUrl, placeHolderHeight: 44)
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            Spacer()
                .frame(width: 10)
            VStack(alignment: .leading, spacing: 10) {
                Text(model.title)
                    .lineLimit(2)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                Text(model.byLine)
                    .font(.system(size: 12))
                    .foregroundColor(.gray.opacity(0.7))
                HStack(spacing: .zero) {
                    Spacer()
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 12, height: 10)
                    Spacer()
                        .frame(width: 6)
                    Text(model.publishedDateTimestamp)
                        .font(.system(size: 12))
                }
                .foregroundColor(.gray.opacity(0.7))
            }
            .multilineTextAlignment(.leading)
            Spacer()
                .frame(width: 10)
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14, weight: .bold))
                .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
