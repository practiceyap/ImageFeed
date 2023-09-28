//
//  NetworkError.swift
//  ImageFeed
//
//  Created by Muller Alexander on 28.09.2023.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}
