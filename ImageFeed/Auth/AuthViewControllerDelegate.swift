//
//  AuthViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Muller Alexander on 21.09.2023.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}
