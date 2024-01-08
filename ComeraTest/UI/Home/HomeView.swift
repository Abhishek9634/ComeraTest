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
                .onAppear {
                    viewModel.fetchArticles()
                }
        }
    }
    
    private var parentView: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.articles) {
                    Text($0.title)
                        .padding()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
