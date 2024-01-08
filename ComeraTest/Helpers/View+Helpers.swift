//
//  View+Helpers.swift
//  ComeraTest
//
//  Created by Abhishek Thapliyal on 08/01/24.
//

import SwiftUI

typealias ActionHandler = () -> Void
typealias AlertModel = AlertModifier.AlertModel
typealias AlertButton = AlertModifier.AlertButton
typealias AlertPresentationStyle = AlertModifier.PresentationStyle

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

// MARK: - Show Alert Dialog
extension View {
    func showAlert(
        alertModel: AlertModel,
        presentationStyle: AlertPresentationStyle = .alert,
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(
            AlertModifier(
                alertModel: alertModel,
                presentationStyle: presentationStyle,
                isPresented: isPresented
            )
        )
    }
}

struct AlertModifier: ViewModifier {
    let alertModel: AlertModel
    let presentationStyle: PresentationStyle
    
    @Binding var isPresented: Bool
    
    init(alertModel: AlertModel, presentationStyle: PresentationStyle, isPresented: Binding<Bool>) {
        self.alertModel = alertModel
        self.presentationStyle = presentationStyle
        self._isPresented = isPresented
    }
    
    func body(content: Content) -> some View {
        switch presentationStyle {
        case .alert:
            showAlert(content: content)
        case .bottomSheet(let titleVisibility):
            bottomSheet(content: content, titleVisibility: titleVisibility)
        }
    }
    
    private func showAlert(content: Content) -> some View {
        content
            .alert(alertModel.title ?? "", isPresented: $isPresented) {
                ForEach(alertModel.buttons) { button in
                    Button(button.title, action: button.action)
                }
            } message: {
                Text(alertModel.message ?? "")
            }
    }
    
    private func bottomSheet(content: Content, titleVisibility: Visibility = .hidden) -> some View {
        content
            .confirmationDialog(
                alertModel.title ?? "",
                isPresented: $isPresented,
                titleVisibility: titleVisibility,
                presenting: alertModel,
                actions: {
                    ForEach($0.buttons) { button in
                        Button(button.title, action: button.action)
                    }
                },
                message: {
                    if let message = $0.message {
                        Text(message)
                    }
                }
            )
    }
}

extension AlertModifier {
    enum PresentationStyle {
        case alert
        case bottomSheet(titleVisibility: Visibility)
    }
}

extension AlertModifier {
    struct AlertModel {
        let title: String?
        let message: String?
        let buttons: [AlertButton]
    }
    
    struct AlertButton {
        let title: String
        let action: ActionHandler
        
        init(title: String, action: @escaping ActionHandler = {}) {
            self.title = title
            self.action = action
        }
    }
}

extension AlertModel {
    static let `default` = AlertModel(title: nil, message: nil, buttons: [])
}

extension AlertButton: Identifiable {
    var id: String {
        title
    }
}
