//
//  ProfilePresenterSpy.swift
//  ImageFeedTests
//
//  Created by Muller Alexander on 27.09.2023.
//

import ImageFeed
import Foundation

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var view: ProfileViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func exitProfile() {}
    func updateAvatar() {}
}
