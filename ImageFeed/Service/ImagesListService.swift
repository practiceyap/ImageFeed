//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Muller Alexander on 12.09.2023.
//

import UIKit

final class ImagesListService {
    
    private (set) var photos: [Photo] = []
       
    static let DidChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    private var lastLoadedPage: Int?
    
    func fetchPhotosNextPage() {
//        let nextPage = lastLoadedPage == nil
//           ? 1
//           : lastLoadedPage!.number + 1
    }
}
