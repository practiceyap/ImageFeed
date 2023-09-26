//
//  ProfilePresenterProtocol.swift
//  ImageFeed
//
//  Created by Muller Alexander on 26.09.2023.
//

import Foundation

public protocol ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
    func exitProfile()
    func updateAvatar()
}
