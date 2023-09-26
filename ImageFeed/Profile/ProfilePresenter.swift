//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by Muller Alexander on 26.09.2023.
//

import UIKit

final class ProfilePresenter {
    var view: ProfileViewControllerProtocol?
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let imagesListService = ImagesListService.shared

    func viewDidLoad() {
        view?.updateProfileDetails(profile: profileService.profile)
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func exitProfile() {
        OAuth2TokenStorage().token = nil
        WebViewViewController.clean()
        cleanService()

        guard let window = UIApplication.shared.windows.first else {
            return assertionFailure("Invalid Configuration")
        }
        window.rootViewController = SplashViewController()
    }

    private func cleanService() {
        profileService.cleanProfile()
        profileImageService.cleanProfileImageURL()
        imagesListService.cleanImagesList()
    }

    func updateAvatar() {
        guard
            let profileImageURL = profileImageService.avatarURL,
            let imageURL = URL(string: profileImageURL)
        else { return }
        view?.updateAvatar(imageURL: imageURL)
    }
}
