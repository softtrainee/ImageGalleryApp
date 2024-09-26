//
//  ColorfulSpinner.swift
//  ImageGalleryApp
//
//  Created by Mohit Gupta on 26/09/24.
//

import Foundation
import SwiftUI
 

struct ColorfulProgressView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 8)
                .frame(width: 50, height: 50)

            // Animated gradient arc
            Circle()
                .trim(from: 0.0, to: 0.7)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]), center: .center),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .frame(width: 50, height: 50)
                .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
                .onAppear {
                    isAnimating = true
                }
        }
    }
}
