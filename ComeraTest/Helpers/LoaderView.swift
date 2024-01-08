//
//  Loader.swift
//  ComeraTest
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import SwiftUI

struct LoaderView: UIViewRepresentable {
    @Binding var isLoading: Bool

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .black
        view.hidesWhenStopped = true
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isLoading ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

private struct LoaderViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            LoaderView(isLoading: $isLoading)
        }
    }
}

extension View {
    func loader(isLoading: Binding<Bool>) -> some View {
        modifier(LoaderViewModifier(isLoading: isLoading))
    }
}
