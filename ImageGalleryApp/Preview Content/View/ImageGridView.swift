//
//  ImageGridView.swift
//  ImageGalleryApp
//
//  Created by Mohit Gupta on 26/09/24.
//

import Foundation
import SwiftUI

struct ImageGridView: View {
    @ObservedObject var viewModel = ImageGalleryViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.photos) { photo in
                        NavigationLink(destination: ImageDetailView(viewModel: viewModel, photo: photo)) {
                            ImageView(photo: photo, viewModel: viewModel)
                        }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .onAppear {
                if viewModel.photos.isEmpty {
                    viewModel.fetchPhotos()
                }
            }
            .onScrollToBottom {
                viewModel.fetchPhotos()
            }
            .navigationTitle("Image Gallery")
        }
    }
}

// Helper ScrollView extension to detect when scrolled to the bottom
struct ScrollViewHelper: ViewModifier {
    let onScrollToBottom: () -> Void

    func body(content: Content) -> some View {
        GeometryReader { proxy in
            ScrollView {
                content
                    .background(
                        GeometryReader { geo in
                            Color.clear
                                .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                        }
                    )
            }
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                if value < proxy.size.height {
                    onScrollToBottom()
                }
            }
        }
    }
}

extension View {
    func onScrollToBottom(perform: @escaping () -> Void) -> some View {
        self.modifier(ScrollViewHelper(onScrollToBottom: perform))
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct ImageView: View {
    let photo: Photo
    @ObservedObject var viewModel: ImageGalleryViewModel
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            if let loadedImage = image {
                Image(uiImage: loadedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            } else {
                ColorfulProgressView()
                    .frame(height: 150)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .onAppear {
                        viewModel.loadImage(for: photo) { loadedImage in
                            image = loadedImage
                        }
                    }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}
