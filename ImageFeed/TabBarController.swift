//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Muller Alexander on 08.09.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let imagesListViewController = storyboard.instantiateViewController(
            withIdentifier: "ImagesListViewController"
        ) as? ImagesListViewController
        guard let imagesListViewController else { return }
        imagesListViewController.configure(ImagesListViewPresenter())
        
        view.backgroundColor = .ypBlack
        
        let profileViewController = ProfileViewController()
        profileViewController.configure(ProfilePresenter())
        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil
        )
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}
