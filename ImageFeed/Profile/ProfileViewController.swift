//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Muller Alexander on 19.07.2023.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
  
    private let profileView = ProfileView(frame: .zero)
    private var profileImageServiceObserver: NSObjectProtocol?
    private var alertPresenter: AlertPresenterProtocol?
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let imagesListService = ImagesListService.shared
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        updateProfileDetails(profile: profileService.profile)
        alertPresenter = AlertPresenter(viewController: self)
        
        profileView.didTapLogoutButton = { [weak self] in
            self?.showAlertExitProfile()
        }
    }
    
    func updateProfileDetails(profile: Profile?) {
        guard let profile = profile else {
            return
        }
        profileView.profileName?.text = profile.name
        profileView.profileLogin?.text = profile.loginName
        profileView.profileDescription?.text = profile.bio
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            }
        updateAvatar()
    }
    
    private func exitProfile() {
        OAuth2TokenStorage().token = nil
        WebViewViewController.clean()
        cleanService()
        
        guard let window = UIApplication.shared.windows.first else {
            return assertionFailure("Invalid Configuration")
        }
        window.rootViewController = SplashViewController()
    }
    
    private func showAlertExitProfile() {
        let model = AlertModelTwoButton(
            title: "Пока, пока!",
            message: "Уверены что хотите выйти?",
            buttonTextOne: "Да",
            buttonTextTwo: "Нет",
            completionOne: { [weak self] in
                guard let self = self else { return }
                exitProfile()
            },
            completionTwo: nil
        )
        alertPresenter?.showTwoButton(model)
    }
    
    private func cleanService() {
        profileService.cleanProfile()
        profileImageService.cleanProfileImageURL()
        imagesListService.cleanImagesList()
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let imageURL = URL(string: profileImageURL)
        else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 61)
        profileView.profileImageView.kf.indicatorType = .activity
        profileView.profileImageView.kf.setImage(with: imageURL,
                                    placeholder: UIImage(named: "stub"),
                                    options: [.processor(processor)])
    }
}

