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
        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")
        imagesListViewController.tabBarItem = UITabBarItem(title: nil,
                                                           image: UIImage(named: "tab_editorial_active"),
                                                           selectedImage: nil)
        view.backgroundColor = .ypBlack

        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "tab_profile_active"),
            selectedImage: nil
        )
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}
