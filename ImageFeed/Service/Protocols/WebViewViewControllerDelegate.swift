//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Muller Alexander on 26.09.2023.
//

import Foundation

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
