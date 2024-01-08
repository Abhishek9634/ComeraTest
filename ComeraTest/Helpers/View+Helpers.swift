//
//  View+Helpers.swift
//  AvomaTest
//
//  Created by Abhishek Thapliyal on 04/12/23.
//

import SwiftUI

typealias ActionHandler = () -> Void

// MARK: - Rounded Corners
private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: - View Did Load like `viewDidLoad` in `UIKit`
private struct ViewDidLoadModifier: ViewModifier {
    @State private var isLoaded = false
    let action: ActionHandler
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if !isLoaded {
                    action()
                    isLoaded = true
                }
            }
    }
}

extension View {
    func viewDidLoad(action: @escaping ActionHandler) -> some View {
        modifier(ViewDidLoadModifier(action: action))
    }
}
