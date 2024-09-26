//
//  ColorfulNavigationBar.swift
//  ImageGalleryApp
//
//  Created by Mohit Gupta on 26/09/24.
//

import Foundation
import SwiftUI

struct ColorfulNavigationBar: ViewModifier {
    var backgroundColor: UIColor
    var titleColor: UIColor

    init(backgroundColor: UIColor, titleColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = titleColor
    }

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline) // or .large based on your design
            .navigationBarItems(leading: Button(action: {
                // Add navigation bar button actions here if needed
            }, label: {
                Image(systemName: "arrow.left").foregroundColor(Color(titleColor)) // Back button color
            }))
    }
}

extension View {
    func colorfulNavigationBar(backgroundColor: UIColor, titleColor: UIColor) -> some View {
        self.modifier(ColorfulNavigationBar(backgroundColor: backgroundColor, titleColor: titleColor))
    }
}

