//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Muller Alexander on 17.08.2023.
//

import UIKit

final class OAuth2TokenStorage {
    
    private enum Keys: String {
        case token
    }
    
    private let userDefaults = UserDefaults.standard
    
    var token: String? {
        get {
            userDefaults.string(forKey: Keys.token.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.token.rawValue)
        }
    }
}
