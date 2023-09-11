//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Muller Alexander on 19.07.2023.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    private let profileService = ProfileService.shared
    let profileView = ProfileView(frame: .zero)
    private var profileImageServiceObserver: NSObjectProtocol?
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateProfileDetails(profile: profileService.profile)
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
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let imageURL = URL(string: profileImageURL)
        else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 61)
        profileView.profileImageView.kf.indicatorType = .activity
        profileView.profileImageView.kf.setImage(with: imageURL,
                                    placeholder: UIImage(named: "placeholder.jpeg"),
                                    options: [.processor(processor)])
    }
}
