//
//  Photo.swift
//  ImageGalleryApp
//
//  Created by Mohit Gupta on 26/09/24.
//

import Foundation
struct Photo: Identifiable, Codable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}


