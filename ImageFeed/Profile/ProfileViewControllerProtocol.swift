//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Muller Alexander on 26.09.2023.
//

import UIKit

public protocol ProfileViewControllerProtocol: AnyObject {
    func updateProfileDetails(profile: Profile?)
    func updateAvatar(imageURL: URL)
}
