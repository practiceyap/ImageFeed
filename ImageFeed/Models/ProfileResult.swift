//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Muller Alexander on 30.08.2023.
//

import UIKit

public struct ProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
}
