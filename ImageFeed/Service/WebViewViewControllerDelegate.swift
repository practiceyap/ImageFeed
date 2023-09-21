//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Muller Alexander on 21.09.2023.
//

import UIKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
