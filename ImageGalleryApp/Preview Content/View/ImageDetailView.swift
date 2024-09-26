//
//  ImageDetailView.swift
//  ImageGalleryApp
//
//  Created by Mohit Gupta on 26/09/24.
//

import Foundation
import SwiftUI

struct ImageDetailView: View {
    @ObservedObject var viewModel: ImageGalleryViewModel
    let photo: Photo
    @State private var currentIndex: Int = 0
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            VStack {
                if let url = URL(string: viewModel.photos[currentIndex].url) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .scaleEffect(scale)
                            .gesture(MagnificationGesture().onChanged { value in
                                scale = value
                            })
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                }

                Text(viewModel.photos[currentIndex].title)
                    .font(.headline)
                    .padding()

                Spacer()

                HStack {
                    Button(action: previousImage) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    Spacer()
                    Button(action: nextImage) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                .padding()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
        }
        .padding()
        .navigationBarTitle("Image Details", displayMode: .inline)
        .onAppear {
            currentIndex = viewModel.photos.firstIndex(where: { $0.id == photo.id }) ?? 0
        }
        .colorfulNavigationBar(backgroundColor: UIColor.systemTeal, titleColor: UIColor.white) // Custom bar color
    }

    private func nextImage() {
        if currentIndex < viewModel.photos.count - 1 {
            currentIndex += 1
        }
    }

    private func previousImage() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}
