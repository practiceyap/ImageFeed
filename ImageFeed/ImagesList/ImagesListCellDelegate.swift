//
//  ImagesListCellDelegate.swift
//  ImageFeed
//
//  Created by Muller Alexander on 15.09.2023.
//

import UIKit

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}
