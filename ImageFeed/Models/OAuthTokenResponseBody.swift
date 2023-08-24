//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Muller Alexander on 17.08.2023.
//

import UIKit

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}
