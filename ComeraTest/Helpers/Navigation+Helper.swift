//
//  Navigation+Helper.swift
//  ComeraTest
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import SwiftUI

private struct SegueModifier<T, Destination: View>: ViewModifier {
    @Binding var viewModel: T?
    let destination: (T) -> Destination
    
    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(
                    isActive: .init(
                        get: { viewModel != nil },
                        set: { viewModel = $0 ? viewModel : nil }
                    )
                ) {
                    if let viewModel = viewModel {
                        destination(viewModel)
                    }
                } label: {
                    EmptyView()
                }
                    .isDetailLink(false)
            )
    }
}

extension View {
    func segue<T, Destination: View>(
        viewModel: Binding<T?>,
        destination: @escaping (T) -> Destination
    ) -> some View {
        modifier(SegueModifier(viewModel: viewModel, destination: destination))
    }
}
