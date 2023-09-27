//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Muller Alexander on 27.09.2023.
//

import ImageFeed
import Foundation

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    func updateProfileDetails(profile: Profile?) {}
    func updateAvatar(imageURL: URL) {}
}
