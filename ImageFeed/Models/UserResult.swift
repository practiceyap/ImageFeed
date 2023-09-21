//
//  UserResult.swift
//  ImageFeed
//
//  Created by Muller Alexander on 31.08.2023.
//

import UIKit

struct UserResult: Codable {
    let profileImage: ProfileImage?
}

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
}
