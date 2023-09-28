//
//  ImagesListViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Muller Alexander on 27.09.2023.
//

import ImageFeed
import Foundation

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
    var presenter: ImageFeed.ImagesListViewPresenterProtocol?
    func updateTableViewAnimated(oldCount: Int, newCount: Int) {}
    func showError() {}
    func updateImagesListDetails() {}
}
