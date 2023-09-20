//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Muller Alexander on 15.09.2023.
//

import UIKit

struct PhotoResult: Codable {
    let id: String
    let createdAt: String?
    let width: Int
    let height: Int
    let description: String?
    let likedByUser: Bool
    let urls: UrlsResult
}

struct PhotoLikeResult: Codable {
    let photo: PhotoResult?
}
