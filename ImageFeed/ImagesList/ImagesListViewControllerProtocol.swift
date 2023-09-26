//
//  ImagesListViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Muller Alexander on 26.09.2023.
//

import UIKit

public protocol ImagesListViewControllerProtocol: AnyObject {
    func updateTableViewAnimated(oldCount: Int, newCount: Int)
    func showError()
    func updateImagesListDetails()
}
