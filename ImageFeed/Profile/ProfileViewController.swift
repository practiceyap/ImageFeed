//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Muller Alexander on 19.07.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func loadView() {
        view = ProfileView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
