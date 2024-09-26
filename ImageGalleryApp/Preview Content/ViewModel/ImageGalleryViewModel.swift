//
//  ImageGalleryViewModel.swift
//  ImageGalleryApp
//
//  Created by Mohit Gupta on 26/09/24.
//

import Foundation
import SwiftUI

class ImageGalleryViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var isLoading: Bool = false
    private let cache = NSCache<NSNumber, UIImage>()
    private var currentPage = 1
    private let limit = 20

    init() {
        fetchPhotos()
    }

    func fetchPhotos() {
        guard !isLoading else { return }
        isLoading = true

        let urlString = "https://jsonplaceholder.typicode.com/photos?_limit=\(limit)&_page=\(currentPage)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let newPhotos = try JSONDecoder().decode([Photo].self, from: data)
                    DispatchQueue.main.async {
                        self.photos.append(contentsOf: newPhotos)
                        self.isLoading = false
                        self.currentPage += 1
                    }
                } catch {
                    print("Error decoding photos: \(error)")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
        }.resume()
    }

    func loadImage(for photo: Photo, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: NSNumber(value: photo.id)) {
            completion(cachedImage)
            return
        }

        guard let url = URL(string: photo.thumbnailUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.cache.setObject(image, forKey: NSNumber(value: photo.id))
                    completion(image)
                }
            }
        }.resume()
    }
}
