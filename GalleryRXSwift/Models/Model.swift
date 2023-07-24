//
//  Model.swift
//  GalleryRXSwift
//
//  Created by Anatolii Shumov on 21/07/2023.
//

import Foundation

struct Model: Hashable, Codable {
    let previewURL: String
    let largeImageURL: String
    let tags: String
}
